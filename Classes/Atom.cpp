#include <iostream>
#include <string>
#include "Atom.h"

using namespace std;

Atom::Atom (string name){
  atom_name = name;
  negated = false;
}
void Atom::negate(){
  negated = true;
}
bool Atom::get_negated(){
  return negated;
}
string Atom::name(){
  if(Atom::get_negated()){
    return "Not " + atom_name;
  }
  else{
    return atom_name;
  }
}
