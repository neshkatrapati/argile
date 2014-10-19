%{
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()
%}
%%
[ \t\n]         ;
[0-9]+\.[0-9]+  { cout << "Found a float :" << yytext << endl; }
[0-9]+          { cout << "Found an int :" << yytext << endl; }
[a-zA-Z0-9]+    { cout << "Found a string :" << yytext << endl; }
%%
main() {

    FILE *myfile = fopen("demo.al", "r");
   // make sure it's valid:
    if (!myfile) {
        cout << "I can't open demo.al!" << endl;
        return -1;
    }
    // set lex to read from it instead of defaulting to STDIN:
    yyin = myfile;
    yylex();
}