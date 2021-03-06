%{
#include  <stdio.h>
#include "mylanguage.tab.h"
#include <iostream>
#include <fstream> 
using namespace std;

extern void  yyerror(char const *s);
extern void  FillTempStack();

#define YY_DECL extern "C" int yylex()

/* 
  This let me receive the program as an ifstream object and tells Flex to parse that object. 
  This way I can, later (in the Ejecutor) receive input from cin. 
  YY_INPUT
*/
ifstream a_stream;
#undef YY_INPUT
#define YY_INPUT(buf, result, max) (result = a_stream.readsome(buf,max))

%}

INTEGER         [0-9]+
FLOATINGPOINT   [0-9]+"."[0-9]*
STRING          \"[a-zA-Z0-9]*\"
ID              [a-z][a-z0-9]*

%%
"main"                    { return MAIN; }
"def"                     { return DEF; }
"call"                     { return CALL;}
"num"                     { return NUM; }
"lett"                    { return LETT;}
"if"                      { return IF;}
"else"                    { return ELSE;}
"for"                     { return FOR;}
"do"                      { return DO;}
"while"                   { return WHILE;}
"("                       { return OPAR;}
")"                       { return CPAR;}
"["                       { return OB;}
"]"                       { return CB;}
"{"                       { return OKEY;}
"}"                       { return CKEY;}
";"                       { return SEMICOLON;}
","                       { return COMMA;}
"="                       { return EQUAL;}
"\""                      { return QUOTE;}
"<"                       { return LT;}
">"                       { return GT;}
"<="                      { return LET;}
">="                      { return GET;}
"=="                      { return EQU;}
"!="                      { return NEQ;}
"+"                       { return PLUS;}
"-"                       { return MINUS;}
"*"                       { return MULT;}
"/"                       { return DIV;}
"and"                     { return AND;}
"or"                      { return OR;}
"not"                     { return NOT;}
"input"                   { return INPUT;}
{INTEGER}                 {
                           //printf( "got INTEGER: %s (%d)\n", yytext, atoi(yytext));
                           yylval.integer = atoi(yytext);
                           return INTEGER;
                          }
{FLOATINGPOINT}           {
                           //printf( "got FLOATINGPOINT: %s (%g)\n", yytext, atof(yytext));
                           yylval.fp = atof(yytext);
                           return FLOATINGPOINT;
                          }
{ID}                      {
                           //printf( "got ID: %s\n", yytext );
                           yylval.string = yytext;
                           return ID;
                          }
{STRING}                  {
                           //printf( "got STRING: %s \n", yytext);
                           yylval.string = yytext;
                           return STRING;
                          }
[ \t\n]+                  ;   // do  nothing  on  whitespace
.                         {ECHO; yyerror("error");}

%%

int yywrap(){
  return 1;
}

int main(int argc, char** argv){

  if(argc != 2){
      cout << "USAGE: "<< argv[0]<< " <filename>"<<endl;
      return -1;
    } else {
      a_stream.open(argv[1], std::ifstream::in);
    }

    FillTempStack();
    return yyparse ();
}
