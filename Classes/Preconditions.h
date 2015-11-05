#include <iostream>
#include <string>
#include <list>
#include "Predicate.h"

using namespace std;

class Preconditions {
    int count;
    list<Predicate *> preconditions;
  public:
    Preconditions ();
    string print_preconditions();
    void add_predicate(Predicate *);
};
