################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CC_SRCS += \
../apriltags/src/Edge.cc \
../apriltags/src/FloatImage.cc \
../apriltags/src/GLine2D.cc \
../apriltags/src/GLineSegment2D.cc \
../apriltags/src/Gaussian.cc \
../apriltags/src/GrayModel.cc \
../apriltags/src/Homography33.cc \
../apriltags/src/MathUtil.cc \
../apriltags/src/Quad.cc \
../apriltags/src/Segment.cc \
../apriltags/src/TagDetection.cc \
../apriltags/src/TagDetector.cc \
../apriltags/src/TagFamily.cc \
../apriltags/src/UnionFindSimple.cc 

OBJS += \
./apriltags/src/Edge.o \
./apriltags/src/FloatImage.o \
./apriltags/src/GLine2D.o \
./apriltags/src/GLineSegment2D.o \
./apriltags/src/Gaussian.o \
./apriltags/src/GrayModel.o \
./apriltags/src/Homography33.o \
./apriltags/src/MathUtil.o \
./apriltags/src/Quad.o \
./apriltags/src/Segment.o \
./apriltags/src/TagDetection.o \
./apriltags/src/TagDetector.o \
./apriltags/src/TagFamily.o \
./apriltags/src/UnionFindSimple.o 

CC_DEPS += \
./apriltags/src/Edge.d \
./apriltags/src/FloatImage.d \
./apriltags/src/GLine2D.d \
./apriltags/src/GLineSegment2D.d \
./apriltags/src/Gaussian.d \
./apriltags/src/GrayModel.d \
./apriltags/src/Homography33.d \
./apriltags/src/MathUtil.d \
./apriltags/src/Quad.d \
./apriltags/src/Segment.d \
./apriltags/src/TagDetection.d \
./apriltags/src/TagDetector.d \
./apriltags/src/TagFamily.d \
./apriltags/src/UnionFindSimple.d 


# Each subdirectory must supply rules for building sources it contributes
apriltags/src/%.o: ../apriltags/src/%.cc
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -I/usr/include/eigen3 -I/usr/include/opencv -I/usr/include/opencv2 -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


