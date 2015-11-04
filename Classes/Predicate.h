#include <iostream>
#include <string>
#include <list>
#include "Variable.h"
using namespace std;

class Predicate {
    string predicate_name;
    bool negated;
    list<Variable *> list_parameters;
  public:
    Predicate ();
    void set_name(string);
    void negate();
    bool get_negated();
    string name();
    void add_parameter(Variable *);
};
