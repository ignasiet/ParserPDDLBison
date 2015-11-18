#include <iostream>
#include <string>
#include <vector>
#include "Effect.h"

using namespace std;

Effect::Effect(){

}

bool Effect::is_conditional(){
  return conditional;
}

bool Effect::is_observation(){
  return observation;
}

void Effect::add_condition(ListPredicates* condition){
  conditions = condition;
}

void Effect::add_effect(ListPredicates* effect){
  effects = effect;
}

string Effect::print_effect(){
  return "";
}
