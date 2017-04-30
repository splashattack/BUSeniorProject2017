#include "AprilTagInterface.hpp"
#include "FifoComm.hpp"
#include <iostream>
#include <string>
// quad.py needs to be running in order for this to work properly
using namespace std;

int main()
{
    AprilTagInterface april;
    while(true)
    {
        string msg = receiveMessage();
        cout << "Got message: " << msg << endl;
        if(msg == "GET")
        {
            april.processFrame();
            tagFrame frame = april.getFrame();
            if (!frame.empty())
            {
                for( tagFrame::iterator it = frame.begin(); it != frame.end(); it++)
                {
                    cout << "Tag id " << it->id << " detected at: (" << it->pos_x << ", " << it->pos_y << ", " << it->pos_z << ")" << endl;
                    ostringstream os;
                    os << it->id << "," << it->hamming << "," << it->distance << "," << it->pos_x << "," << it->pos_y << "," << it->pos_z << "," << it->time;
                    sendMessage(os.str());
                }
            }
            else
            {
                sendMessage("NONE");
            }
        }
        else if(msg == "CHECK")
        {
            sendMessage("ACK");
        }
    }
}