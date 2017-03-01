#include "FifoComm.hpp"

using namespace std;

void sendMessage(string str)
{
    cout << "Sending " << str << endl;
    ostringstream os;
    os << "echo " << str << " > " << FIFO_FILE_1 << endl;
    system(os.str().c_str());
    return;
}

string recieveMessage()
{
    int server_to_client = open(FIFO_FILE_2, O_RDONLY);
    char str[140];
    if(read(server_to_client,str,sizeof(str)) < 0){
        perror("Read:"); //error check
        exit(-1);
    }
    close(server_to_client);
    return str;
}

/*
template <class T>
T requestParam(string param)
{
    sendMessage(param);
    string resp = recieveMessage();
    T retVal;
    switch(param)
    {
        //double values
        case "lat":
        case "lon":
        case "alt":
        case "altitude":
        case "yaw":
        case "pitch":
        case "roll":
            retVal = stod(resp);
           
    }
}
*/