/*
 * George Fayette
 * CIS 343
 * Language Creation
 * 3-14-2020
 * zoomjoystrong lexer file
*/

%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap
%option nounput
%option noinput

%%

[-+]?[0-9]*\.[0-9]+	{ yylval.f = atof(yytext); return FLOAT; }	/* Catch all floating point numbers */
[+-]?[0-9]+		{ yylval.i = atoi(yytext); return INT; }	/* Catch all integers */
point			{ return POINT; }				/* Catch all point tokens */
line			{ return LINE; }				/* Catch all line tokens */
circle			{ return CIRCLE; }				/* Catch all circle tokens */
rectangle		{ return RECTANGLE; }				/* Catch all rectangle tokens */
set_color		{ return SET_COLOR; }				/* Catch all set_color tokens */
;			{ return END_STATEMENT; }			/* Catch all end_statement tokens */
[ \t\n]			;						/* Catch all whitespace and do nothing */
.			{ return OTHER; }				/* Catch all other characters on the stream */

%%
