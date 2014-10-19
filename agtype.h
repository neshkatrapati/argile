#include <iostream>
using namespace std;
union PrimitiveElementType {
      int ival;
      float fval;
      char *sval;
      int typestring;
};
typedef union PrimitiveElementType PrimitiveElementType;


union YYSTYPE {
    PrimitiveElementType elem;
};
