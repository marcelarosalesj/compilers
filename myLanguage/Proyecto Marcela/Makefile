CC = g++
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

all: myLanguage

myLanguage: mylanguage.l mylanguage.y
	flex mylanguage.l
	bison -d mylanguage.y
	g++ lex.yy.c mylanguage.tab.c mylanguage.tab.h -std=c++11 -g -o myLang


clean:
	\rm myLang lex.yy.c mylanguage.tab.c mylanguage.tab.h
