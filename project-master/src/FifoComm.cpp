#include "FifoComm.hpp"

void sendMessage(std::string str)
{
    std::cout << "Sending " << str << std::endl;
    std::ostringstream os;
    os << "echo " << str << " > " << FIFO_FILE_1 << std::endl;
    system(os.str().c_str());
    return;
}

std::string recieveMessage()
{
    int client_to_server = open(FIFO_FILE_2, O_RDONLY);
    char str[140];
    if(read(client_to_server,str,sizeof(str)) < 0){
        perror("Read:"); //error check
        exit(-1);
    }
    close(client_to_server);
    string retStr = str;
    retStr = retStr.substr(0,retStr.find('\n'));
    return retStr;
}
