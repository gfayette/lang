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

draw_prog:		error
		|	draw_stmt
		|	draw_stmt END
		|	draw_prog draw_stmt
		|	draw_prog draw_stmt END
;

draw_stmt:		draw_expr END_STATEMENT
;

draw_expr:	line
		|	point
		|	circle
		|	rectangle
		|	set_color			
;

line:	LINE INT INT INT INT
		{ line($2, $3, $4, $5); }
;

point:	POINT INT INT
		{ point($2, $3); }
;

circle:	CIRCLE INT INT INT
		{ circle($2, $3, $4); }
;

rectangle:	RECTANGLE INT INT INT INT
		{ rectangle($2, $3, $4, $5); }
;

set_color:	SET_COLOR INT INT INT
		{	if($2 > 255 || $3 > 255 || $4 > 255){
				printf("color value too high\n");
			} else if ($2 < 0 || $3 < 0 || $4 < 0){
				printf("color value too low\n");
			} else { 
				set_color($2, $3, $4);
			}
		}
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
