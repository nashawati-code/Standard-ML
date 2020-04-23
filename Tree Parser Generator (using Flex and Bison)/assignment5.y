
%{

#include "tree.h"

#include <stdio.h>

extern FILE *yyin;
FILE* outFile;

int yylex();
void yyerror(const char* s);

%}

%union{
    char*           idName;
    unsigned int    constVal;
    BindingList*    bindingList;
    Binding*        binding;
    Expr*           expr;
}

/* Terminals */
%token    val
%token    <idName> id
%token    EQ 
%token    PLUS  
%token    SUB 
%token    TIMES 
%token    DIV 
%token    GREATER 
%token    LESS 
%token    orelse 
%token    andalso 
%token    RIGHTPAR
%token    LEFTPAR
%token    fun
%token    IF
%token    then
%token    ELSE
%token    <constVal> true
%token    <constVal> false 
%token    <constVal> int_const

/* Non-terminals */
%type <bindingList> binding_list
%type <binding>     binding
%type <expr>        expr
%type <expr>        op_expr
%type <expr>        call_expr
%type <expr>        basic_expr

/* Start Symbol */
%start              program

/* Precedence and Associativity */
%left orelse
%left andalso
%left GREATER LESS
%left PLUS SUB
%left TIMES DIV

%%

/* Production Rules and Actions */

program:    binding_list        {printBindingList($1, outFile)}
            | /* empty */       { }
            ;

binding_list:   binding_list binding            {$$ = mergeBindingListAndBinding($1, $2)}
                | binding                       {$$ = createBindingListFromBinding($1)}
                ;

binding:    val id EQ expr              {$$ = createVariableBinding($2, $4)}
            | fun id id EQ expr         {$$ = createFunctionBinding($2, $3, $5)}
            ;

expr:   IF expr then expr ELSE expr     {$$ = createIfThenElseExpr($2, $4, $6)}
        | op_expr    
        ;
    
op_expr:    op_expr PLUS op_expr        {$$ = createAddExpr($1, $3)}
            | op_expr SUB op_expr       {$$ = createSubExpr($1, $3)}
            | op_expr TIMES op_expr     {$$ = createMulExpr($1, $3)}
            | op_expr DIV op_expr       {$$ = createDivExpr($1, $3)}
            | op_expr GREATER op_expr   {$$ = createGreaterThanExpr($1, $3)}
            | op_expr LESS op_expr      {$$ = createLessThanExpr($1, $3)}
            | op_expr andalso op_expr   {$$ = createAndExpr($1, $3)}
            | op_expr orelse op_expr    {$$ = createOrExpr($1, $3)}
            | call_expr{ }
            ;

call_expr:    call_expr basic_expr      {$$ = createCallExpr($1, $2)}
            | basic_expr    
            ;

basic_expr:   RIGHTPAR expr LEFTPAR     {$$ = createParenthesesExpr($2)}
            | id                        {$$ = createIDExpr($1)}
            | int_const                 {$$ = createIntConstExpr($1)}
            | true                      {$$ = createTrueExpr()}
            | false                     {$$ = createFalseExpr()}
            ;
%%

#include <stdlib.h>
int main(int argc, char **argv){
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    const char* outFileName = (argc > 2)?argv[2]:"test.dot";
    yyin = fopen(inFileName, "r");
    outFile = fopen(outFileName, "w");
    fprintf(outFile, "digraph tree {\n");
    do {
        yyparse();
    } while(!feof(yyin));
    fprintf(outFile, "}\n");
    fclose(yyin);
    fclose(outFile);
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}

