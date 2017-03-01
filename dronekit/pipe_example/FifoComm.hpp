#ifndef _FIFO_COMM_HPP
#define _FIFO_COMM_HPP
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

#define FIFO_FILE_1  "/tmp/client_to_server_fifo"
#define FIFO_FILE_2  "/tmp/server_to_client_fifo"

void sendMessage(string str);
string recieveMessage();

#endif