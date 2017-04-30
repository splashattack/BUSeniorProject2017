#include "AprilTagInterface.hpp"
#include "FifoComm.hpp"
#include <iostream>
#include <string>
// quad.py needs to be running in order for this to work properly
using namespace std;

int main()
{
    while(true)
    {
        string msg = receiveMessage();
        cout << "Got message: " << msg << endl;
        if(msg == "GET")
        {
            sendMessage("SEND");
        }
        else if(msg == "CHECK")
        {
            sendMessage("ACK");
        }
    }
}