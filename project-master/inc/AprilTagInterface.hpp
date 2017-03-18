/*
 * AprilTagInterface.hpp
 *
 *  Created on: Dec 22, 2016
 *      Author: test
 */

#ifndef APRILTAGINTERFACE_HPP_
#define APRILTAGINTERFACE_HPP_

#define EXPOSURE_CONTROL 1
#define ORIENTATION 1

#include <string>
#include <list>
#include <vector>

#include <cstdio>
#include <iostream>
#include <sys/time.h>

#if EXPOSURE_CONTROL==1
//exposure control
#include <libv4l2.h>
#include <linux/videodev2.h>
#include <fcntl.h>
#include <errno.h>
#endif

// OpenCV library for easy access to USB camera and drawing of images
// on screen
#include "opencv2/opencv.hpp"

#include "TagDetector.h"
#include "Tag16h5.h"
#include "Tag25h7.h"
#include "Tag25h9.h"
#include "Tag36h9.h"
#include "Tag36h11.h"


struct detectionInfo {
    int id;
    double hamming;
    double distance;
    double pos_x;
    double pos_y;
    double pos_z;
    double time;
};

typedef std::vector<detectionInfo> tagFrame;

class AprilTagInterface {
    AprilTags::TagDetector* m_tagDetector;
    AprilTags::TagCodes m_tagCodes;

    bool m_timing; // print timing information for each tag extraction call

    int m_width; // image size in pixels
    int m_height;
    double m_tagSize; // April tag side length in meters of square black frame
    double m_fx; // camera focal length in pixels
    double m_fy;
    double m_px; // camera principal point
    double m_py;

    int m_deviceId; // camera id (in case of multiple cameras)

#if EXPOSURE_CONTROL==1
    int m_exposure;
    int m_gain;
    int m_brightness;
#endif

    std::list<std::string> m_imgNames;

    cv::VideoCapture m_cap;

    tagFrame m_frame;
public:
    AprilTagInterface();
    virtual ~AprilTagInterface();

    void processFrame();
    inline tagFrame getFrame() {return m_frame;};
};

#endif /* APRILTAGINTERFACE_HPP_ */
