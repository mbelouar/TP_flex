/*** Definition Section has one variable
which can be accessed inside yylex()
and main() ***/

%{
#include <stdio.h>
%}

identifier [ ]?[A-Za-z_]([A-Za-z_]|[0-9])*[ ]?
word [ ]?debut|fin|si|alors|sinon|finsi[ ]?
string [ ]?\".+\"[ ]?
number [ ]?0|[1-9][0-9]*[ ]?
operator [ ]?[-+*/<>]|\-\-|\+\+|\=\=|\!\=|\=\=\=|mod[ ]?
assignment [ ]?:=[ ]?

%%

{identifier} {fprintf(yyout,"\n\t\t<span style=\"color: blue;\">%s</span>",yytext);} 
{word} {fprintf(yyout,"\n\t\t<strong>%s</strong>\n",yytext);}
{string} {fprintf(yyout,"\n\t\t<em>%s</em>\t",yytext);}
{number} {fprintf(yyout,"\n\t\t<span style=\"color: green;\">%s</span>",yytext);} 
{operator} {fprintf(yyout,"\n\t\t<span style=\"color: red;\">%s</span>",yytext);}
{assignment} {fprintf(yyout,"\n\t\t<span>%s</span>",yytext);} 
[\n] {fprintf(yyout,"\n\t\t<br>\t");}
. printf("ERROR\n");

%%

int yywrap(){ return 1;}
int main() 
{
char input_filename[20];
printf("Please enter the name of the input file to be scanned: ");
gets(input_filename);
yyin=fopen(input_filename, "r");
char output_filename[20];
printf("Please enter the name of the output file where the HTML code will be written: ");
gets(output_filename);
yyout=fopen(output_filename, "w+");
fprintf(yyout,"<!DOCTYPE html>\n");
fprintf(yyout,"<html>\n\t<head>\n\t\t<meta charset=\"UTF-8\">\n\t\t<title>FLEX</title>\n");
fprintf(yyout,"\t</head>\n\t<body>\n");
yylex();
fprintf(yyout,"\n\t</body>\n</html>");
fclose(yyin);
return 0;
}