#include <iostream>
#include <string>
#include <vector>
#include "Predicate.h"

using namespace std;

class ListPredicates {
    int count;
    vector<Predicate *> predicates;
  public:
    ListPredicates ();
    string print_predicates();
    void add_predicate(Predicate *);
};
