%{
    FILE* outFile;
    void printKeyword(const char* s) {
        fprintf(outFile, "<span style=\"color:#a0a000;\">%s</span>", s);
    }
    void printBuiltInTypes(const char* s) {
        fprintf(outFile, "<span style=\"color:#00c000;\">%s</span>", s);
    }
    void printLiterals(const char* s){
        fprintf(outFile, "<span style=\"color:#ff0000;\">%s</span>", s);
    }
    void printIdentifiersUpper(const char* s){
        fprintf(outFile, "<span style=\"color:#ff00ff;\">%s</span>", s);
    }
    void printIdentifiersLower(const char* s){
        fprintf(outFile, s);
    }
    void printOperatorSeparator(const char* s){
        fprintf(outFile, "<span style=\"color:#0000ff;\">%s</span>", s);
    }
    void printComments(const char* s){
        fprintf(outFile, "<span style=\"color:#00aaff;\">%s</span>", s);
    }
    void whitespace(const char* s){
        fprintf(outFile, s);
    }
%}
%%
    /* Rules for keywords */
val|datatype|of|fun|let|in|end|if|then|else|orelse|andalso|while printKeyword(yytext);

    /* Rules for built-in types */
int|bool|string printBuiltInTypes(yytext);

    /* Rule for integer and boolean literals */
[0-9]+|true|false printLiterals(yytext);

    /* Rule for identifiers */
[A-Z][a-zA-Z_0-9]* printIdentifiersUpper(yytext);
[a-z_][a-zA-Z_0-9]* printIdentifiersLower(yytext);

    /* Rules for operators and separators */
[\+|\-|\*|\+|\||\=>|\<=|\>=|\=|\<|\>|\::|\:|\.|\[|\]|\,|\(|\)|\;|/!=|/!|/~|/->] printOperatorSeparator(yytext);

    /* Rule for string literal */
    /* Hint: you can call input() to read the next character in the stream */
\"(([^\"]|\\\")*[^\\])?\" printLiterals(yytext);

    /* Rule for comment */
    /* Hint: you can call input() to read the next character in the stream */
    /* Hint: you can call unput(char) to return a character to the stream after reading it */
\(\*.*\*\) printComments(yytext);

    /* Rule for whitespace */
[ ] whitespace("&nbsp;");
[\n\r] whitespace("<br>");
[\t] whitespace("&nbsp;&nbsp;&nbsp;&nbsp;");

    /* Catch unmatched tokens */
.               fprintf(stderr, "INVALID TOKEN: %s\n", yytext);

%%

int main(int argc, char** argv) {
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    const char* outFileName = (argc > 2)?argv[2]:"test.html";
    yyin = fopen(inFileName, "r");
    outFile = fopen(outFileName, "w");
    fprintf(outFile, "<html>\n<body><tt>\n");
    yylex();
    fprintf(outFile, "</body>\n</html></tt>\n");
    fclose(yyin);
    fclose(outFile);
    return 0;
}
int yywrap() {
    return 1;
}

