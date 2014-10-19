%{
#include <iostream>
#include "agtype.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
#include "argile.tab.h"
%}
%%
[ \t\n]         ;
bus             {return BUS; }
\/               {return BLKSTART;}
\\               {return BLKEND;}
\<               {return PUSH;}
>               {return PULL;}
[0-9]+\.[0-9]+  { yylval.elem.fval = atof(yytext); yylval.elem.typestring = 2; return FLOAT;}
[0-9]+          { yylval.elem.ival = atoi(yytext); yylval.elem.typestring = 1; return INT;}
[a-zA-Z0-9]+    { 
                  yylval.elem.sval = strdup(yytext);} {
                  yylval.elem.typestring = 3;
                  return STRING;
                }
%%
