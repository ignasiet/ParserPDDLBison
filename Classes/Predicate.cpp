#include <iostream>
#include <string>
#include <list>
#include "Predicate.h"

using namespace std;

Predicate::Predicate (){
  negated = false;
}
void Predicate::set_name (string name){
  predicate_name = name;
  negated = false;
}

void Predicate::negate(){
  negated = true;
}
bool Predicate::get_negated(){
  return negated;
}
string Predicate::name(){
  vector<Variable*>::iterator iter;
  string return_string;
  if(Predicate::get_negated()){
    return_string = "Not " + predicate_name;
  }
  else{
    return_string = predicate_name;
  }
  for(iter = list_parameters.begin(); iter != list_parameters.end(); iter++) {
    return_string = return_string + "-Parameter: " + (*iter)->get_name() + " ";
  }
  return return_string;
}

void Predicate::add_parameter(Variable *var){
  list_parameters.push_back(var);
}
