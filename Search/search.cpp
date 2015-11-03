// constructing priority queues
#include <iostream>       // std::cout
#include <queue>          // std::priority_queue
#include <vector>         // std::vector
#include <functional>     // std::greater
#include "Node.cpp"
using namespace std;

class mycomparison
{
  public:
    bool operator() (Node lhs, Node rhs)
    {
      return (lhs.value() > rhs.value());
    }
};

int main()
{
    priority_queue<Node, vector<Node>, mycomparison> pq;
    //Node 1
    Node n1 = Node ("p");
    n1.new_value(2);
    pq.push(n1);
    //Node 2
    Node n2 = Node ("q");
    n2.new_value(3);
    pq.push(n2);
    Node n3 = pq.top();
    pq.pop();
    cout << n3.print() << endl;
}
