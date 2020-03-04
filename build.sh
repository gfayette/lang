#! /usr/bin/env bash
bison -d zoomjoystrong.y
flex zoomjoystrong.lex
clang -Wall -o zjs zoomjoystrong.c lex.yy.c zoomjoystrong.tab.c -lSDL2 -lm
