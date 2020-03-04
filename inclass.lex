%{
	// Definitions
	#include <stdio.h>
	void print(char* str, char* yytext);
%}

%%

^[A-Za-z]+[ ][A-Za-z]+  { print("NAME", yytext); }
^[1-9][:alnum: ]+("Ave"|"Dr"|"St")  { print("ADDRESS", yytext); }
^[A-Za-z ],  { print("CITY", yytext); }
[A-Z]{2}  { print("STATE", yytext); }
[0-9]{5}  { print("ZIPCODE", yytext); }
[.]*  {  print("EXTRA", yytext); }

%%

	// Code

void print(char* str, char* yytext){
	printf("%s\t\t(%s)\n", str, yytext);
}
