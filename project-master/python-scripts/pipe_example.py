import os
import errno
import re

class Modes:
    SABILIZE,LOITER,AUTO,GUIDED,RTL,LAND = range(6)

FIFO_1 = "/tmp/client_to_server_fifo"
FIFO_2 = "/tmp/server_to_client_fifo"

def repsond(resp):
  os.system("echo " + resp + " > " + FIFO_2)
  return
   

try:
    os.mkfifo(FIFO_1)
    os.mkfifo(FIFO_2)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

while True:
    print("Opening FIFO...")
    with open(FIFO_1) as fifo:
        print("FIFO opened")
        while True:
            data = fifo.read()
            if len(data) == 0:
                break
            data.replace('\n', '');
            if data == "hello\n":
                print "hello"
                respond("hello");
            elif data == "position\n":
                print "position"
                respond(str(10));
            else:
                print "Not Found."

               