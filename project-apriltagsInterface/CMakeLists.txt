cmake_minimum_required(VERSION 2.6)
project(proj)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")

include_directories ("${PROJECT_SOURCE_DIR}/lib/AprilTags")
add_subdirectory ("${PROJECT_SOURCE_DIR}/lib/AprilTags")
set (EXTRA_LIBS ${EXTRA_LIBS} apriltaglib)

include_directories ("${PROJECT_SOURCE_DIR}/sources")
add_subdirectory ("${PROJECT_SOURCE_DIR}/sources")
set (EXTRA_LIBS ${EXTRA_LIBS} sources)

find_package(OpenCV REQUIRED)
if ( NOT OpenCV_FOUND )
    message( FATAL_ERROR "Could not locate OpenCV installation.")
endif()
include_directories(${OpenCV_INCLUDE_DIRS})
set (EXTRA_LIBS ${EXTRA_LIBS} ${OpenCV_LIBS})

find_package(Eigen3 REQUIRED)
if ( NOT EIGEN3_FOUND )
    message( FATAL_ERROR "Could not locate Eigen3 installation.")
endif()
include_directories(${EIGEN3_INCLUDE_DIR})

find_package(V4L2 REQUIRED)
if ( NOT V4L2_FOUND )
    message( FATAL_ERROR "Could not locate V4L2 installation.")
endif()
include_directories(${V4L2_INCLUDE_DIRS})
set (EXTRA_LIBS ${EXTRA_LIBS} ${V4L2_LIBRARIES})

link_libraries(${EXTRA_LIBS})
add_subdirectory("${PROJECT_SOURCE_DIR}/example")
