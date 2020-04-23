%{

#include "tree.h"
#include "assignment5.tab.h"

#include <stdio.h>
#include <string.h>

%}

%option noyywrap

id [a-zA-Z_][a-zA-Z_0-9]*
int_const [0-9]+
%%

    /* Rules for keywords */
val { return val; }
fun { return fun; }
andalso { return andalso; }
orelse { return orelse; }
IF { return IF; }
then { return then; }
ELSE { return ELSE; }


    /* Rules for integer and boolean literals */
{int_const}     { yylval.constVal = atoi(yytext); return int_const; }
true            {yylval.constVal = 1; return true;}
false           {yylval.constVal = 0; return false;}

    /* Rules for identifiers */
{id}            { yylval.idName = strdup(yytext); return id; }


    /* Rules for operators and separators */
"=" { return EQ; }
"+" { return PLUS; }
"-" { return SUB; }
"*" { return TIMES; }
"/" { return DIV; }
">" { return GREATER; }
"<" { return LESS; }
"(" { return RIGHTPAR; }
")" { return LEFTPAR; }


    /* Rule for whitespace */
[ \t\n\r]*


    /* Catch unmatched tokens */
.           { fprintf(stderr, "Unrecognized token: %s\n", yytext); }

%%

