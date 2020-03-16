/*
 * George Fayette
 * CIS 343
 * Language Creation
 * 3-14-2020
 * zoomjoystrong parser file
*/

%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}

%error-verbose
%start draw_prog

%union { int i; float f; }

// Token for the end of a program.
// Doesn't seem to be necessary, "$end" is already recognized and handled automatically.
%token END 	
%token END_STATEMENT 	// Token for the end of a statement.	
%token POINT 		// Token for the beginning of a draw point statement.
%token LINE 		// Token for the beginning of a draw line statement.
%token CIRCLE 		// Token for the beginning of a draw circle statement.
%token RECTANGLE 	// Token for the beginning of a draw rectangle statement.
%token SET_COLOR 	// Token for the beginning of a set color statement.
%token INT 		// Token for integers.
%token FLOAT		// Token for floats.
%token OTHER		// Token which matches invalid input.

%type<i> INT
%type<f> FLOAT

%%

// error - handles invalid statements gracefully.
// The remaining grammar defines empty programs, single statement programs,
// and multi-statement programs.
draw_prog:	error
		|	draw_stmt
		|	draw_prog draw_stmt
;

// Handle all statements
draw_stmt:	draw_op END_STATEMENT
;

// Handle all operations
draw_op:	line
		|	point
		|	circle
		|	rectangle
		|	set_color			
;

// Handle line operations
line:		LINE INT INT INT INT
		{ line($2, $3, $4, $5); }
;

// Handle point operations
point:		POINT INT INT
		{ point($2, $3); }
;

// Handle circle operations
circle:		CIRCLE INT INT INT
		{ circle($2, $3, $4); }
;

// Handle rectangle operations
rectangle:	RECTANGLE INT INT INT INT
		{ rectangle($2, $3, $4, $5); }
;

// Handle set_color operations
// Check for valid input values (0 <= value <= 255)
set_color:	SET_COLOR INT INT INT
		{	
			if($2 > 255 || $3 > 255 || $4 > 255){
				printf("Color value too large.\n");
			} else if ($2 < 0 || $3 < 0 || $4 < 0){
				printf("Color value too small.\n");
			} else { 
				set_color($2, $3, $4);
			}
		}
%%

int main(int argc, char** argv){
	setup();	// Create environment for draw operations
	yyparse();	// Read input and execute program
	finish();	// Perform cleanup operations
	return 0;	// Exit gracefully
}

// Method for displaying error messages
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}
