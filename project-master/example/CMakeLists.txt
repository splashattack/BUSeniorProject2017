cmake_minimum_required (VERSION 2.6)

#add_executable(apriltags_demo apriltags_demo.cpp Serial.cpp)
#pods_install_executables(apriltags_demo)

add_executable(aptiltags_interface DetectionTest.cpp)
target_link_libraries(aptiltags_interface ${EXTRA_LIBS})

add_executable(fifo_example fifo.cpp)
target_link_libraries(fifo_example ${EXTRA_LIBS})