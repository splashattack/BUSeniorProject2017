# Install script for directory: /home/user/shared/Quadcopter-Repo/apriltags

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/user/shared/Quadcopter-Repo/apriltags/build")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/user/shared/Quadcopter-Repo/apriltags/pod-build/lib/libapriltags.a")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/AprilTags" TYPE FILE FILES
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Edge.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/FloatImage.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Gaussian.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/GLine2D.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/GLineSegment2D.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/GrayModel.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Gridder.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Homography33.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/MathUtil.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/pch.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Quad.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Segment.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag16h5.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag16h5_other.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag25h7.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag25h9.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag36h11.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag36h11_other.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/Tag36h9.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/TagDetection.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/TagDetector.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/TagFamily.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/UnionFindSimple.h"
    "/home/user/shared/Quadcopter-Repo/apriltags/AprilTags/XYWeight.h"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/user/shared/Quadcopter-Repo/apriltags/pod-build/lib/pkgconfig/apriltags.pc")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/user/shared/Quadcopter-Repo/apriltags/pod-build/example/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

file(WRITE "/home/user/shared/Quadcopter-Repo/apriltags/pod-build/${CMAKE_INSTALL_MANIFEST}" "")
foreach(file ${CMAKE_INSTALL_MANIFEST_FILES})
  file(APPEND "/home/user/shared/Quadcopter-Repo/apriltags/pod-build/${CMAKE_INSTALL_MANIFEST}" "${file}\n")
endforeach()
