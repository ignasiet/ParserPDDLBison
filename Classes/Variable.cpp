#include <iostream>
#include <string>
#include <list>
#include "Variable.h"

using namespace std;

Variable::Variable(string name){
  var_name = name;
}

void Variable::set_type(string type_name){
  type = type_name;
}

string Variable::get_long_name(){
  return var_name + " " + type;
}

string Variable::get_name(){
  return var_name;
}
