/*
 * detectorTest.cpp
 *
 *  Created on: Dec 22, 2016
 *      Author: test
 */


#include"AprilTagInterface.hpp"

int main()
{
	AprilTagInterface april;
	while(true)
	{
		april.processFrame();
		tagFrame frame = april.getFrame();
	}
}
