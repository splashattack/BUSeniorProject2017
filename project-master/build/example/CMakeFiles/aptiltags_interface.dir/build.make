# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/user/project-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/user/project-master/build

# Include any dependencies generated for this target.
include example/CMakeFiles/aptiltags_interface.dir/depend.make

# Include the progress variables for this target.
include example/CMakeFiles/aptiltags_interface.dir/progress.make

# Include the compile flags for this target's objects.
include example/CMakeFiles/aptiltags_interface.dir/flags.make

example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o: example/CMakeFiles/aptiltags_interface.dir/flags.make
example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o: ../example/DetectionTest.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/user/project-master/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o"
	cd /home/user/project-master/build/example && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o -c /home/user/project-master/example/DetectionTest.cpp

example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.i"
	cd /home/user/project-master/build/example && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/user/project-master/example/DetectionTest.cpp > CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.i

example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.s"
	cd /home/user/project-master/build/example && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/user/project-master/example/DetectionTest.cpp -o CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.s

example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.requires:
.PHONY : example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.requires

example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.provides: example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.requires
	$(MAKE) -f example/CMakeFiles/aptiltags_interface.dir/build.make example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.provides.build
.PHONY : example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.provides

example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.provides.build: example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o

# Object files for target aptiltags_interface
aptiltags_interface_OBJECTS = \
"CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o"

# External object files for target aptiltags_interface
aptiltags_interface_EXTERNAL_OBJECTS =

example/aptiltags_interface: example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o
example/aptiltags_interface: example/CMakeFiles/aptiltags_interface.dir/build.make
example/aptiltags_interface: lib/AprilTags/libapriltaglib.a
example/aptiltags_interface: src/libsources.a
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_videostab.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_video.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ts.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_superres.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_stitching.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_photo.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ocl.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_objdetect.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ml.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_legacy.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_imgproc.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_highgui.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_gpu.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_flann.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_features2d.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_core.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_contrib.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_calib3d.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libv4l2.so
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libv4l1.so
example/aptiltags_interface: lib/AprilTags/libapriltaglib.a
example/aptiltags_interface: src/libsources.a
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_videostab.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_video.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ts.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_superres.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_stitching.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_photo.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ocl.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_objdetect.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ml.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_legacy.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_imgproc.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_highgui.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_gpu.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_flann.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_features2d.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_core.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_contrib.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_calib3d.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libv4l2.so
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libv4l1.so
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_photo.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_legacy.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_video.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_objdetect.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_ml.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_calib3d.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_features2d.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_highgui.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_imgproc.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_flann.so.2.4.9
example/aptiltags_interface: /usr/lib/i386-linux-gnu/libopencv_core.so.2.4.9
example/aptiltags_interface: example/CMakeFiles/aptiltags_interface.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable aptiltags_interface"
	cd /home/user/project-master/build/example && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/aptiltags_interface.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
example/CMakeFiles/aptiltags_interface.dir/build: example/aptiltags_interface
.PHONY : example/CMakeFiles/aptiltags_interface.dir/build

example/CMakeFiles/aptiltags_interface.dir/requires: example/CMakeFiles/aptiltags_interface.dir/DetectionTest.cpp.o.requires
.PHONY : example/CMakeFiles/aptiltags_interface.dir/requires

example/CMakeFiles/aptiltags_interface.dir/clean:
	cd /home/user/project-master/build/example && $(CMAKE_COMMAND) -P CMakeFiles/aptiltags_interface.dir/cmake_clean.cmake
.PHONY : example/CMakeFiles/aptiltags_interface.dir/clean

example/CMakeFiles/aptiltags_interface.dir/depend:
	cd /home/user/project-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/project-master /home/user/project-master/example /home/user/project-master/build /home/user/project-master/build/example /home/user/project-master/build/example/CMakeFiles/aptiltags_interface.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : example/CMakeFiles/aptiltags_interface.dir/depend
