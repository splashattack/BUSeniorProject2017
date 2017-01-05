/*
 * AprilTagInterface.cpp
 *
 *  Created on: Dec 22, 2016
 *      Author: test
 */

#include "AprilTagInterface.hpp"

// utility function to provide current system time (used below in
// determining frame rate at which images are being processed)
double tic() {
  struct timeval t;
  gettimeofday(&t, NULL);
  return ((double)t.tv_sec + ((double)t.tv_usec)/1000000.);
}


AprilTagInterface::AprilTagInterface() :
	m_tagDetector(NULL),
    m_tagCodes(AprilTags::tagCodes36h11),
    m_timing(true),

    m_width(320),
    m_height(240),
    m_tagSize(0.166),
    m_fx(600),
    m_fy(600),
    m_px(m_width/2),
    m_py(m_height/2),

#if EXPOSURE_CONTROL==1
    m_exposure(-1),
    m_gain(-1),
    m_brightness(-1),
#endif
    m_deviceId(0)
{
	m_tagDetector = new AprilTags::TagDetector(m_tagCodes);

#if EXPOSURE_CONTROL==1
    // manually setting camera exposure settings; OpenCV/v4l1 doesn't
    // support exposure control; so here we manually use v4l2 before
    // opening the device via OpenCV; confirmed to work with Logitech
    // C270; try exposure=20, gain=100, brightness=150

    std::string video_str = "/dev/video0";
    video_str[10] = '0' + m_deviceId;
    int device = v4l2_open(video_str.c_str(), O_RDWR | O_NONBLOCK);

    if (m_exposure >= 0) {
      // not sure why, but v4l2_set_control() does not work for
      // V4L2_CID_EXPOSURE_AUTO...
      struct v4l2_control c;
      c.id = V4L2_CID_EXPOSURE_AUTO;
      c.value = 1; // 1=manual, 3=auto; V4L2_EXPOSURE_AUTO fails...
      if (v4l2_ioctl(device, VIDIOC_S_CTRL, &c) != 0) {
        std::cout << "Failed to set... " << strerror(errno) << std::endl;
      }
      std::cout << "exposure: " << m_exposure << std::endl;
      v4l2_set_control(device, V4L2_CID_EXPOSURE_ABSOLUTE, m_exposure*6);
    }
    if (m_gain >= 0) {
      std::cout << "gain: " << m_gain << std::endl;
      v4l2_set_control(device, V4L2_CID_GAIN, m_gain*256);
    }
    if (m_brightness >= 0) {
      std::cout << "brightness: " << m_brightness << std::endl;
      v4l2_set_control(device, V4L2_CID_BRIGHTNESS, m_brightness*256);
    }
    v4l2_close(device);
#endif

    // find and open a USB camera (built in laptop camera, web cam etc)
    m_cap = cv::VideoCapture(m_deviceId);
    if(!m_cap.isOpened())
    {
        std::cerr << "ERROR: Can't find video device " << m_deviceId << "\n";
        exit(1);
    }
    m_cap.set(CV_CAP_PROP_FRAME_WIDTH, m_width);
    m_cap.set(CV_CAP_PROP_FRAME_HEIGHT, m_height);
    std::cout << "Camera successfully opened (ignore error messages above...)" << std::endl;
    std::cout << "Actual resolution: "
         << m_cap.get(CV_CAP_PROP_FRAME_WIDTH) << "x"
         << m_cap.get(CV_CAP_PROP_FRAME_HEIGHT) << std::endl;
}

AprilTagInterface::~AprilTagInterface() {
	// TODO Auto-generated destructor stub
}


void AprilTagInterface::processFrame()
{
	cv::Mat image;
	cv::Mat image_gray;

	int frame = 0;
	double last_t = tic();
	// capture frame
	m_cap >> image;

	// alternative way is to grab, then retrieve; allows for
	// multiple grab when processing below frame rate - v4l keeps a
	// number of frames buffered, which can lead to significant lag
	//      m_cap.grab();
	//      m_cap.retrieve(image);

	// detect April tags (requires a gray scale image)
	cv::cvtColor(image, image_gray, CV_BGR2GRAY);
	double t0;
	if (m_timing) {
	  t0 = tic();
	}
	std::vector<AprilTags::TagDetection> detections = m_tagDetector->extractTags(image_gray);
	if (m_timing) {
		double dt = tic()-t0;
	    std::cout << "Extracting tags took " << dt << " seconds." << std::endl;
	}

	//Update frame with current detections
	m_frame.clear();
	std::cout << detections.size() << " tags detected:" << std::endl;
	for (uint8_t i=0; i<detections.size(); i++) {
		detectionInfo currentTagInfo;
	    std::cout << "  Id: " << detections[i].id
	              << " (Hamming: " << detections[i].hammingDistance << ")";

	    currentTagInfo.id = detections[i].id;

	    currentTagInfo.hamming = detections[i].hammingDistance;
	    // recovering the relative pose of a tag:
	    // NOTE: for this to be accurate, it is necessary to use the
	    // actual camera parameters here as well as the actual tag size
	    // (m_fx, m_fy, m_px, m_py, m_tagSize)
	    Eigen::Vector3d translation;
	    Eigen::Matrix3d rotation;
	    detections[i].getRelativeTranslationRotation(m_tagSize, m_fx, m_fy, m_px, m_py,
	                                                 translation, rotation);

	    std::cout << "  distance=" << translation.norm()
	              << "m, x=" << translation(0)
	              << ", y=" << translation(1)
	              << ", z=" << translation(2);
	    std::cout << std::endl;

	    currentTagInfo.distance = translation.norm();
	    currentTagInfo.pos_x = translation(0);
	    currentTagInfo.pos_y = translation(1);
	    currentTagInfo.pos_z = translation(2);
	    currentTagInfo.time = tic();
	    // Also note that for SLAM/multi-view application it is better to
	    // use reprojection error of corner points, because the noise in
	    // this relative pose is very non-Gaussian; see iSAM source code
	    // for suitable factors.
	    m_frame.push_back(currentTagInfo);
	}

	// print out the frame rate at which image frames are being processed
	frame++;
	if (frame % 10 == 0) {
		double t = tic();
	    std::cout << "  " << 10./(t-last_t) << " fps" << std::endl;
	    last_t = t;
	}

}
