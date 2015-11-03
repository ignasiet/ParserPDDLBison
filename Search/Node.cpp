#include <iostream>
#include <string>
using namespace std;

class Node{
    //State
    string state_representation;
    //Level
    int level;
    //Priority: Heuristic cost
    int heuristic;
    //Pointer to the parent Node
    Node* parent;
  public:
    //Expand
    //Get parent
    Node (string state){
      state_representation = state;
    }

    string print(){
      return state_representation;
    }

    void new_value(int h){
      this->heuristic = h;
    }

    int value(){
      return this->heuristic;
    }
};
