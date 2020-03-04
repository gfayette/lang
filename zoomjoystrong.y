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

draw_prog:	drawing
		{ printf("drawing program\n"); }
;

drawing:	draw_stmt
		|	drawing draw_stmt 
		{ printf("drawing\n"); }
;

draw_stmt:	line
		|	point
		|	circle
		|	rectangle
		|	set_color			
		{ printf("stmt\n"); }
;

line:	LINE INT INT INT INT END_STATEMENT
		{ printf("line\n"); }
;

point:	POINT INT INT END_STATEMENT
		{ printf("point\n"); point($2, $3); }
;

circle:	CIRCLE INT INT INT END_STATEMENT
		{ printf("circle\n"); }
;

rectangle:	RECTANGLE INT INT INT INT END_STATEMENT
		{ printf("rectangle\n"); }
;

set_color:	SET_COLOR INT INT INT END_STATEMENT
		{ printf("color\n"); }
%%

int main(int argc, char** argv){
	printf("setup\n");
	setup();
	yyparse();
	finish();
	printf("finish\n");
	return 0;
}

void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}