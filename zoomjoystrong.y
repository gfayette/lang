%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start draw_prog

%union { int i; float f; }

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

draw_prog:	draw_stmt
		|	draw_prog draw_stmt 
;

draw_stmt:	line
		|	point
		|	circle
		|	rectangle
		|	set_color			
;

line:	LINE INT INT INT INT END_STATEMENT
		{ line($2, $3, $4, $5); }
;

point:	POINT INT INT END_STATEMENT
		{ point($2, $3); }
;

circle:	CIRCLE INT INT INT END_STATEMENT
		{ circle($2, $3, $4); }
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT
		{ rectangle($2, $3, $4, $5); }
;

set_color:	SET_COLOR INT INT INT END_STATEMENT
		{ set_color($2, $3, $4); }
%%

int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
