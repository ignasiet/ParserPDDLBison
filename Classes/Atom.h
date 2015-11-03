#include <iostream>
#include <string>
using namespace std;

class Atom {
    string atom_name;
    bool negated;
  public:
    Atom (string);
    void negate();
    bool get_negated();
    string name();
};
