#include <iostream>
#include <string>
#include <list>

using namespace std;

class Variable {
    string var_name;
    string type;
  public:
    Variable (string);
    void set_type(string);
    string get_name();
    string get_long_name();
};
