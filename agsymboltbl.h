class STVariable {
  char * variable_name;
  PrimitiveElementType elem;
 public:
  STVariable (char * var, PrimitiveElementType el);
  char * getVariableName();
};

STVariable::STVariable (char * var, PrimitiveElementType el) {
  variable_name = var;
  elem = el;
}
char * STVariable::getVariableName(){
  return variable_name;
}

class STList {
  STVariable * var;
  STList *next;
  STList *prev;
 public:
  STList ();
  STList (STVariable v);
  STList * append(STVariable v);
  void print ();
  void setVariable(STVariable v);
  bool isEmpty();
};
STList::STList (){
}

STList::STList (STVariable v) { 
  var = &v;
}

void STList::setVariable (STVariable v){
  var = &v;
}

STList * STList::append(STVariable v) {
  STList * currentList = this;
  STList newList (v);
  while ( currentList -> next ){
    currentList = currentList -> next;
  }
  currentList -> next = &newList;
  newList.prev = currentList;
  return &newList;
}
void STList::print () {
  STList * currentList = this;
  cout << currentList -> var -> getVariableName() << endl;
  while(currentList -> next) {
    currentList = currentList -> next;
    cout << currentList -> var -> getVariableName() << endl; 
  }
}
bool STList::isEmpty(){
  if (this -> next == NULL){
    return true;
  }
  return false;
}

