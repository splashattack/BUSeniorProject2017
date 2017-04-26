import time
import math
import os
import errno
import re
import sys

connection_string = "/dev/ttyS0"
FIFO_1 = "/tmp/server_to_client_fifo"
FIFO_2 = "/tmp/client_to_server_fifo"

try:
    os.mkfifo(FIFO_1)
    os.mkfifo(FIFO_2)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def respond(resp):
  os.system("echo " + resp + " > " + FIFO_1)
  return
   

try:
    os.mkfifo(FIFO_1)
    os.mkfifo(FIFO_2)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

def checkFifo():
    TIMEOUT = 3 # seconds
    os.system("echo CHECK > " + FIFO_2)
    startTime = time.clock();
    with open(FIFO_1) as fifo:
        print("FIFO opened")
        while True:
            print "FIFO is open. Getting data..."
            if ((time.clock() - startTime) >= TIMEOUT):
                print "IPC timeout."
                return ""
            dataStr = fifo.read()
            if len(dataStr) == 0:
                break
            else:
                dataStr.replace('\n', '');
                if ((dataStr != "ACK\n")):
                    sys.exit("IPC Failure. Exiting.")
                else:
                    print "Acknowledged."
                    
def getFifo():
    TIMEOUT = 3 # seconds
    os.system("echo GET > " + FIFO_2)
    startTime = time.clock();
    with open(FIFO_1) as fifo:
        print("FIFO opened")
        while True:
            print "FIFO is open. Getting data..."
            if ((time.clock() - startTime) >= TIMEOUT):
                print "IPC timeout."
                return ""
            dataStr = fifo.read()
            if len(dataStr) == 0:
                break
            else:
                dataStr.replace('\n', '');
                if ((dataStr != "")):
                    print "Got Response: " + dataStr

checkFifo();
getFifo();