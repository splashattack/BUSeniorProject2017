#include FifoComm.hpp

#include <iostream>
#include <string>
#include <sstream>
#include <cstdlib>

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <wait.h>
using namespace std;

void sendMessage(std::string str)
{
    cout << "Sending " << str << endl;
    ostringstream os;
    os << "echo " << str << " > " << FIFO_FILE_1 << endl;
    system(os.str().c_str());
    return;
}

std::string recieveMessage()
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