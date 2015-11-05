#include <iostream>
#include <string>
#include <list>
#include "Predicate.h"

using namespace std;

class Action {
    string action_name;
    bool observation;
    list<Predicate *> preconditions;
  public:
    Action ();
    void set_name(string);
    void set_observation(bool);
    bool is_observation();
    string get_name();
    void add_precondition(Predicate *);
};
