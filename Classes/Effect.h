#include <iostream>
#include <string>
#include <vector>
#include "ListPredicates.h"

using namespace std;

class Effect{
    bool conditional;
    bool observation;
    ListPredicates* conditions;
    ListPredicates* effects;
  public:
    Effect ();
    void set_conditional();
    void set_observation();
    bool is_conditional();
    bool is_observation();
    void add_condition(ListPredicates* condition);
    void add_effect(ListPredicates* effect);
    string print_effect();
};
