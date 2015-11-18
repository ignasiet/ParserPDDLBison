#include <iostream>
#include <string>
#include <list>
#include "ListPredicates.h"

using namespace std;

ListPredicates::ListPredicates(){
  count=0;
}

void ListPredicates::add_predicate(Predicate * pred){
  count++;
  predicates.push_back(pred);
}

string ListPredicates::print_predicates(){
  vector<Predicate*>::iterator iter;
  string return_string;
  for(iter = predicates.begin(); iter != predicates.end(); iter++) {
    return_string = return_string + "-Predicate: " + (*iter)->name() + " ";
  }
  return return_string;
}
