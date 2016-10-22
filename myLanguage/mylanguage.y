  // mylanguage
  //  BISON  file
%{
#include  <stdio.h>
#include  <stdlib.h>
#include <string.h>
extern  int  yylex ();
extern  void  yyerror();
%}


%union {
  char *string;           /* Ptr to constant string (strings are malloc'd) */
  int integer;            /* Constant integer value */
  float fp;               /* Constant floating point value */
}

%start  ROOT
%token <string> MAIN DEF NUM LETT IF ELSE FOR DO WHILE OPAR CPAR OBR CBR SEMICOLON EQUAL QUOTE INTEGER FLOATINGPOINT STRING ID LT GT LET GET EQU NEQ PLUS MINUS MULT DIV AND OR NOT OB CB COMMA 
%type <string> ROOT M FUNCTS FUNCT BLOCK  X  Y  STMT I IE F W DW E PRIO1 ES PRIO2 TA PRIO3 FF X1 X2 X3 X4


%%

ROOT:       FUNCTS M {printf(" OK ROOT\n");}
            ;

FUNCTS:	    FUNCT FUNCTS {printf("*-FUNCTS \n");}
	    	|  {printf("N-FUNCTS \n");}
	    	;

FUNCT:      DEF ID BLOCK {printf("FUNCT \n");}
            ;

M:          MAIN BLOCK {printf("MAIN \n");}
            ;

BLOCK:      OBR LIST CBR  {printf(" BR Blk \n");}
            | STMT
            ;

LIST:       STMT SEMICOLON LIST
            |
            ;

STMT:         NUM ID X  {printf(" NUMDEF \n");}
            | LETT ID Y    {printf(" LETTDEF \n");}
            | I       {printf(" I\n");}
            | F       {printf(" F\n");}
            | W       {printf(" W\n");}
            | DW      {printf(" DW\n");}
            | E    {printf(" E\n");}
            ;

X:          EQUAL E       {printf(" EN X \n");}
            |
            ;

Y:          EQUAL QUOTE STRING QUOTE {printf(" EN Y1\n");}
			| EQUAL QUOTE ID QUOTE {printf(" EN Y2\n");}
            |
            ;

I:          IF OPAR E CPAR BLOCK IE      {printf(" EN IF \n");}
            ;

IE:         ELSE BLOCK                      {printf(" IE ELSE \n");}
            |                                   {printf(" IE NADA \n");}
            ;

F:          FOR OPAR NUM ID EQUAL INTEGER SEMICOLON E SEMICOLON E CPAR BLOCK {printf(" TERMINA FOR\n");}
            ;
W:          WHILE OPAR E CPAR BLOCK
            ;
DW:         DO BLOCK WHILE OPAR E
 CPAR
            ;
E:			ES | ES PRIO1 ES;
PRIO1:		LT | GT | LET | GET | EQU | NEQ;
ES: 		TA | TA PRIO2 ES;
PRIO2:		PLUS | MINUS | OR;
TA: 		FF | FF PRIO3 TA;
PRIO3: 		MULT | DIV | AND;
FF:			INTEGER | FLOATINGPOINT | X1 ID X2;
X1: 		PLUS | MINUS | NOT | ;
X2:			OPAR X3 CPAR | X4;
X3:			E | E COMMA X3;
X4:			OB X3 CB X4 | ;



