#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
© Copyright 2015-2016, 3D Robotics.
guided_set_speed_yaw.py: (Copter Only)

This example shows how to move/direct Copter and send commands in GUIDED mode using DroneKit Python.

Example documentation: http://python.dronekit.io/examples/guided-set-speed-yaw-demo.html
"""

from dronekit import connect, VehicleMode, LocationGlobal, LocationGlobalRelative
from pymavlink import mavutil # Needed for command message definitions
import time
import math
import os
import errno
import re

connection_string = "/dev/ttyS0"
FIFO_1 = "/tmp/server_to_client_fifo"
FIFO_2 = "/tmp/client_to_server_fifo"

try:
    os.mkfifo(FIFO_1)
    os.mkfifo(FIFO_2)
except OSError as oe:
    if oe.errno != errno.EEXIST:
        raise

# Connect to the Vehicle
print 'Connecting to vehicle on: %s' % connection_string
vehicle = connect(connection_string, wait_ready=True, baud=57600)
# Create and open log file
global outFile
outFile = open('location.txt', 'w+')


def print_loc():
    currentLocationStr = str(vehicle.location.global_relative_frame.lat) + " " + \
                             str(vehicle.location.global_relative_frame.lon) + " " + \
                             str(vehicle.location.global_relative_frame.alt) + "\n"
    outFile.write(currentLocationStr);
    return

def arm_and_takeoff(aTargetAltitude):
    """
    Arms vehicle and fly to aTargetAltitude.
    """

    print "Basic pre-arm checks"
    # Don't let the user try to arm until autopilot is ready
    while not vehicle.is_armable:
        print " Waiting for vehicle to initialise..."
        time.sleep(1)

        
    print "Arming motors"
    # Copter should arm in GUIDED mode
    vehicle.mode = VehicleMode("GUIDED")
    vehicle.armed = True

    while not vehicle.armed:      
        print " Waiting for arming..."
        time.sleep(1)

    print "Taking off!"
    vehicle.simple_takeoff(aTargetAltitude) # Take off to target altitude

    # Wait until the vehicle reaches a safe height before processing the goto (otherwise the command 
    #  after Vehicle.simple_takeoff will execute immediately).
    while True:
        print " Altitude: ", vehicle.location.global_relative_frame.alt   
        print_loc();        
        if vehicle.location.global_relative_frame.alt>=aTargetAltitude*0.95: #Trigger just below target alt.
            print "Reached target altitude"
            break
        time.sleep(0.25)

"""
Functions to make it easy to convert between the different frames-of-reference. In particular these
make it easy to navigate in terms of "metres from the current position" when using commands that take 
absolute positions in decimal degrees.

The methods are approximations only, and may be less accurate over longer distances, and when close 
to the Earth's poles.

Specifically, it provides:
* get_location_metres - Get LocationGlobal (decimal degrees) at distance (m) North & East of a given LocationGlobal.
* get_distance_metres - Get the distance between two LocationGlobal objects in metres
* get_bearing - Get the bearing in degrees to a LocationGlobal
"""

def get_location_metres(original_location, dNorth, dEast):
    """
    Returns a LocationGlobal object containing the latitude/longitude `dNorth` and `dEast` metres from the 
    specified `original_location`. The returned LocationGlobal has the same `alt` value
    as `original_location`.

    The function is useful when you want to move the vehicle around specifying locations relative to 
    the current vehicle position.

    The algorithm is relatively accurate over small distances (10m within 1km) except close to the poles.

    For more information see:
    http://gis.stackexchange.com/questions/2951/algorithm-for-offsetting-a-latitude-longitude-by-some-amount-of-meters
    """
    earth_radius = 6378137.0 #Radius of "spherical" earth
    #Coordinate offsets in radians
    dLat = dNorth/earth_radius
    dLon = dEast/(earth_radius*math.cos(math.pi*original_location.lat/180))

    #New position in decimal degrees
    newlat = original_location.lat + (dLat * 180/math.pi)
    newlon = original_location.lon + (dLon * 180/math.pi)
    if type(original_location) is LocationGlobal:
        targetlocation=LocationGlobal(newlat, newlon,original_location.alt)
    elif type(original_location) is LocationGlobalRelative:
        targetlocation=LocationGlobalRelative(newlat, newlon,original_location.alt)
    else:
        raise Exception("Invalid Location object passed")
        
    return targetlocation;


def get_distance_metres(aLocation1, aLocation2):
    """
    Returns the ground distance in metres between two LocationGlobal objects.

    This method is an approximation, and will not be accurate over large distances and close to the 
    earth's poles. It comes from the ArduPilot test code: 
    https://github.com/diydrones/ardupilot/blob/master/Tools/autotest/common.py
    """
    dlat = aLocation2.lat - aLocation1.lat
    dlong = aLocation2.lon - aLocation1.lon
    return math.sqrt((dlat*dlat) + (dlong*dlong)) * 1.113195e5


def get_bearing(aLocation1, aLocation2):
    """
    Returns the bearing between the two LocationGlobal objects passed as parameters.

    This method is an approximation, and may not be accurate over large distances and close to the 
    earth's poles. It comes from the ArduPilot test code: 
    https://github.com/diydrones/ardupilot/blob/master/Tools/autotest/common.py
    """	
    off_x = aLocation2.lon - aLocation1.lon
    off_y = aLocation2.lat - aLocation1.lat
    bearing = 90.00 + math.atan2(-off_y, off_x) * 57.2957795
    if bearing < 0:
        bearing += 360.00
    return bearing;

def goto(dNorth, dEast, gotoFunction=vehicle.simple_goto):
    """
    Moves the vehicle to a position dNorth metres North and dEast metres East of the current position.

    The method takes a function pointer argument with a single `dronekit.lib.LocationGlobal` parameter for 
    the target position. This allows it to be called with different position-setting commands. 
    By default it uses the standard method: dronekit.lib.Vehicle.simple_goto().

    The method reports the distance to target every two seconds.
    """
    
    currentLocation = vehicle.location.global_relative_frame
    targetLocation = get_location_metres(currentLocation, dNorth, dEast)
    targetDistance = get_distance_metres(currentLocation, targetLocation)
    gotoFunction(targetLocation)
    
    #print "DEBUG: targetLocation: %s" % targetLocation
    #print "DEBUG: targetLocation: %s" % targetDistance

    while vehicle.mode.name=="GUIDED": #Stop action if we are no longer in guided mode.
        #print "DEBUG: mode: %s" % vehicle.mode.name
        print_loc();
        remainingDistance=get_distance_metres(vehicle.location.global_relative_frame, targetLocation)
        print "Distance to target: ", remainingDistance
        if remainingDistance<=1:  #targetDistance*0.05: #Just below target, in case of undershoot.
            print "Reached target"
            break;
        time.sleep(0.25)

def send_offset_velocity(velocity_x, velocity_y, velocity_z, duration):
    """
    Move vehicle in direction based on specified velocity vectors and
    for the specified duration.

    This uses the SET_POSITION_TARGET_LOCAL_NED command with a type mask enabling only 
    velocity components 
    (http://dev.ardupilot.com/wiki/copter-commands-in-guided-mode/#set_position_target_local_ned).
    
    Note that from AC3.3 the message should be re-sent every second (after about 3 seconds
    with no message the velocity will drop back to zero). In AC3.2.1 and earlier the specified
    velocity persists until it is canceled. The code below should work on either version 
    (sending the message multiple times does not cause problems).
    
    See the above link for information on the type_mask (0=enable, 1=ignore). 
    At time of writing, acceleration and yaw bits are ignored.
    """
    msg = vehicle.message_factory.set_position_target_local_ned_encode(
        0,       # time_boot_ms (not used)
        0, 0,    # target system, target component
        mavutil.mavlink.MAV_FRAME_BODY_OFFSET_NED, # frame
        0b0000111111000111, # type_mask (only speeds enabled)
        0, 0, 0, # x, y, z positions (not used)
        velocity_x, velocity_y, velocity_z, # x, y, z velocity in m/s
        0, 0, 0, # x, y, z acceleration (not supported yet, ignored in GCS_Mavlink)
        0, 0)    # yaw, yaw_rate (not supported yet, ignored in GCS_Mavlink) 

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
    
    centeredFB = False
    centeredLR = False
    
    
    if (pos_y > 0.5):
        print "Centering L/R... (Left of target)"
        send_offset_velocity(0,-0.5,0,abs(pos_y)*2) #Move Right
        send_offset_velocity(0,0,0,1)
    elif (pos_y < -0.5):
        print "Centering L/R... (Right of target)"
        send_offset_velocity(0,0.5,0,abs(pos_y)*2) #Move Left
        send_offset_velocity(0,0,0,1)
    else:
        print "Centered to L/R!"
        centeredLR = True

    if (pos_z > 0.5):
        print "Centering F/B... (Forward of target)"
        send_offset_velocity(-0.5,0,0,abs(pos_z)*2) #Move Backward
        send_offset_velocity(0,0,0,1)
    elif (pos_z < -0.5):
        print "Centering F/B... (Behind target)"
        send_offset_velocity(0.5,0,0,abs(pos_z)*2) #Move Forward
        send_offset_velocity(0,0,0,1)
    else:
        print "Centered to F/B!"  
        centeredFB = True
    
    return centeredFB and centeredLR
    
    
# HERE WE DO STUFF
checkFifo();

print("Set groundspeed to 5m/s.")
vehicle.groundspeed=5

#Arm and take of to altitude of 5 meters
arm_and_takeoff(5)

print("Position North 8 West 5")
goto(8, -5)

positionAttempts = 0
MAX_POSITION_ATTEMPTS = 5
TARGET_ID = 0;

tagInfo = findTag(TARGET_ID);
while(True):
    tagInfo = findTag(TARGET_ID);
    if(tagInfo):
        print_loc();
        atTag = centerQuad(tagInfo);
        if(atTag):
            print "Successfully centered over target. Landing..."
            break
        else:
            positionAttempts += 1
            if(positionAttempts > MAX_POSITION_ATTEMPTS):
                print "Cound not center over tag. Landing..."
                break
    else:
        print "Lost tag. Landing..."
        break

print("Setting LAND mode...")
vehicle.mode = VehicleMode("LAND")

for i in range(80):
    print_loc();
    time.sleep(0.25);

#Close vehicle object before exiting script
print "Close vehicle object"
vehicle.close()
outFile.close()

print("Completed")