%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+				{ yylval.i = atoi(yytext); return INT; }
end					{ return END; }
point				{ return POINT; }
line				{ return LINE; }
circle				{ return CIRCLE; }
rectangle			{ return RECTANGLE; }
set_color			{ return SET_COLOR; }
;					{ return END_STATEMENT; }
[ \t\n]				;

%%