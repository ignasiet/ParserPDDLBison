#include <iostream>
#include <string>
#include <list>
#include "Action.h"

using namespace std;

Action::Action() {
    observation = false;
}

void Action::set_name(string name){
  action_name = name;
}

string Action::get_name(){
  return action_name;
}

void Action::set_observation(bool o){
  observation = o;
}

bool Action::is_observation(){
  return observation;
}

void Action::add_precondition(Predicate *pred){
  preconditions.push_back(pred);
}
