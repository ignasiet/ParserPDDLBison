#include <iostream>
#include <string>
#include <list>
#include "Preconditions.h"

using namespace std;

Preconditions::Preconditions(){
  count=0;
}

void Preconditions::add_predicate(Predicate * pred){
  count++;
  preconditions.push_back(pred);
}

string Preconditions::print_preconditions(){
  list<Predicate*>::iterator iter;
  string return_string;
  for(iter = preconditions.begin(); iter != preconditions.end(); iter++) {
    return_string = return_string + "-Predicate: " + (*iter)->name() + " ";
  }
  return return_string;
}
