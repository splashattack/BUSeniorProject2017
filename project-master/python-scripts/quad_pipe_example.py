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

def checkFifo():
    TIMEOUT = 3 # seconds
    os.system("echo CHECK > " + FIFO_2)
    startTime = time.clock();
    with open(FIFO_1) as fifo:
        print("FIFO opened")
        while True:
            print "Getting tag data."
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

def getTagInfo():
    #TAG FORMAT IS LIST AS SUCH:
    #[int id,double hamming,double distance,double pos_x,double pos_y,double pos_z,double time]
    TIMEOUT = 3 # seconds
    os.system("echo GET > " + FIFO_2)
    startTime = time.clock();
    with open(FIFO_1) as fifo:
        print("FIFO opened")
        while True:
            print "Getting tag data."
            if ((time.clock() - startTime) >= TIMEOUT):
                print "IPC timeout."
                return ""
            dataStr = fifo.read()
            if len(dataStr) == 0:
                break
            else:
                dataStr.replace('\n', '');
                if ((dataStr != "NONE\n") and (dataStr.find(',')!=-1)):
                    print "FIFO got: " + dataStr
                    return dataStr.split(",")
                else:
                    print "FIFO got: " + dataStr
                    print "No Detection"
                    return ""
                

def findTag(TARGET_ID):
    findAttempts = 0
    MAX_FIND_ATTEMPTS = 5
    while (True):
        #TAG FORMAT IS LIST AS SUCH:
        #[int id,double hamming,double distance,double pos_x,double pos_y,double pos_z,double time]
        info = getTagInfo()
        if (info):
            id = int(info[0])
            pos_x = float(info[3]) # Up/Down (Away from camera)
            pos_y = float(info[4]) # Forward/Back?
            pos_z = float(info[5]) # Left/Right?
            if (id == TARGET_ID):
                print "Found tag " + str(id) + " at " + str(pos_x) + "," + str(pos_y) + ","  + str(pos_z)
                return [pos_x,pos_y,pos_z]
        else:
            findAttempts += 1
            if(findAttempts > MAX_FIND_ATTEMPTS):
                print "Could not find tag."
                return []
            else:
                print "Reattempting image find."


def centerQuad(tagInfo):
    pos_x = tagInfo[0]
    pos_y = tagInfo[1] #Left(+)/Right(-)
    pos_z = tagInfo[2] #Forward(+)/Backward(-)
    print str(pos_x) + "," + str(pos_y) + "," + str(pos_z)
    
    centeredFB = False
    centeredLR = False
    
    
    if (pos_y > 0.5):
        print "Centering L/R... (Left of target)"
        #send_ned_velocity(-0.5,0,0,abs(pos_y)*2) #Move Right
        #send_ned_velocity(0,0,0,1)
    elif (pos_y < -0.5):
        print "Centering L/R... (Right of target)"
        #send_ned_velocity(0.5,0,0,abs(pos_y)*2) #Move Left
        #send_ned_velocity(0,0,0,1)
    else:
        print "Centered to L/R!"
        centeredLR = True

    if (pos_z > 0.5):
        print "Centering F/B... (Forward of target)"
        #send_ned_velocity(0,-0.5,0,abs(pos_y)*2) #Move Backward
        #send_ned_velocity(0,0,0,1)
    elif (pos_z < -0.5):
        print "Centering F/B... (Behind target)"
        #send_ned_velocity(0,0.5,0,abs(pos_y)*2) #Move Forward
        #send_ned_velocity(0,0,0,1)
    else:
        print "Centered to F/B!"  
        centeredFB = True
    
    return centeredFB and centeredLR

    
print "Starting"
checkFifo();
info = findTag(0);
if(info):
    success = centerQuad(info);
    if(success):
        print "Success!"
    else:
        print "Failure!"
else:
    print "No detection, not centering"
