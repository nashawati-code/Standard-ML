ID [a-zA-Z_][a-zA-Z_0-9]*
%%
val printf("VAL\n");
{ID} printf("IDENTIFIER %s\n", yytext);
= printf("EQUALS\n");
[+] printf("PLUS\n");
[0-9]+ printf("INT_CONST %d\n", atoi(yytext));
; printf("SEMICOLON\n");
[ \t\n\r] /* Do not do anything */
. printf("INVALID TOKEN!\n");
%%
int main() {
yylex();
return 0;
}
int yywrap() {
return 1;
}