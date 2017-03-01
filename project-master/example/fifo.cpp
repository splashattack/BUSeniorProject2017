#include "FifoComm.hpp"

// pipe_example.py needs to be running in order for this example to work properly
using namespace std;

int main()
{
    while(true)
    {
        string str;
        cout << "Input message to server: " << endl;
        cin >> str;
        sendMessage(str);
        string str2 = recieveMessage();
        cout << "Got message: " << str2 << endl;
        sendMessage("position");
        int pos = atoi(recieveMessage().c_str());
        cout << "Got Posiiton " << pos << endl;
    }

   return 0;
}