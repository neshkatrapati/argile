%{
#include <cstdio>
#include <iostream>
#include "agtype.h"
#include "agsymboltbl.h"
#include <string.h> 
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void yyerror(const char *s);
void assign_variable(PrimitiveElementType var_string, PrimitiveElementType val);

STList symbol_table;
//global symbol_table;
%}

%define api.value.type {union YYSTYPE}

%token BUS
%token BLKSTART
%token BLKEND
%token PUSH
%token PULL
%token <elem> INT
%token <elem> FLOAT
%token <elem> STRING
%type <elem> anything
%%
argile:
        argile bus
        | argile push
        | bus
        | push
        ;

anything : STRING | INT | FLOAT

push : STRING PUSH anything   {
  cout << $3.sval << endl;
  //  assign_variable($1, $3);
}
;
bus: STRING BLKSTART BUS BLKEND {cout << "bus :" << $1.sval << endl;};



%%


void assign_variable(PrimitiveElementType var_string, PrimitiveElementType val){
  cout << val.ival << endl;
  STVariable var(var_string.sval, val);
  if (symbol_table.isEmpty()){
    symbol_table.setVariable(var);
  }else {
    symbol_table.append(var);
  }
  symbol_table.print();
}


FILE * open_file(char * file_name) {
    FILE *myfile = fopen(file_name, "r");
    if (!myfile) {
        return (FILE *)-1;
    }
    return myfile;
}

main(int argc, char **argv) {
    // open a file handle to a particular file:
    if (argc == 1){
        do {
            yyparse();
        } while (!feof(yyin));
    }else{
        cout << "Input file :: " << argv[1] << endl;
        FILE * my_file = open_file(argv[1]);
        if (my_file != (FILE *) -1){
            yyin = my_file;
            do {
                yyparse();
            } while (!feof(yyin));
        }else{
            cout << "Cannot open the file : " << argv[1];
        }

    }

    // parse through the input until there is no more:


}

void yyerror(const char *s) {
    cout << "EEK, parse error!  Message: " << s << endl;
    exit(-1);
}
