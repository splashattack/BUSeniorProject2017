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
include src/CMakeFiles/sources.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/sources.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/sources.dir/flags.make

src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o: src/CMakeFiles/sources.dir/flags.make
src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o: ../src/AprilTagInterface.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/user/project-master/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o"
	cd /home/user/project-master/build/src && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/sources.dir/AprilTagInterface.cpp.o -c /home/user/project-master/src/AprilTagInterface.cpp

src/CMakeFiles/sources.dir/AprilTagInterface.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sources.dir/AprilTagInterface.cpp.i"
	cd /home/user/project-master/build/src && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/user/project-master/src/AprilTagInterface.cpp > CMakeFiles/sources.dir/AprilTagInterface.cpp.i

src/CMakeFiles/sources.dir/AprilTagInterface.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sources.dir/AprilTagInterface.cpp.s"
	cd /home/user/project-master/build/src && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/user/project-master/src/AprilTagInterface.cpp -o CMakeFiles/sources.dir/AprilTagInterface.cpp.s

src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.requires:
.PHONY : src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.requires

src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.provides: src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.requires
	$(MAKE) -f src/CMakeFiles/sources.dir/build.make src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.provides.build
.PHONY : src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.provides

src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.provides.build: src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o

# Object files for target sources
sources_OBJECTS = \
"CMakeFiles/sources.dir/AprilTagInterface.cpp.o"

# External object files for target sources
sources_EXTERNAL_OBJECTS =

src/libsources.a: src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o
src/libsources.a: src/CMakeFiles/sources.dir/build.make
src/libsources.a: src/CMakeFiles/sources.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library libsources.a"
	cd /home/user/project-master/build/src && $(CMAKE_COMMAND) -P CMakeFiles/sources.dir/cmake_clean_target.cmake
	cd /home/user/project-master/build/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sources.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/sources.dir/build: src/libsources.a
.PHONY : src/CMakeFiles/sources.dir/build

src/CMakeFiles/sources.dir/requires: src/CMakeFiles/sources.dir/AprilTagInterface.cpp.o.requires
.PHONY : src/CMakeFiles/sources.dir/requires

src/CMakeFiles/sources.dir/clean:
	cd /home/user/project-master/build/src && $(CMAKE_COMMAND) -P CMakeFiles/sources.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/sources.dir/clean

src/CMakeFiles/sources.dir/depend:
	cd /home/user/project-master/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/user/project-master /home/user/project-master/src /home/user/project-master/build /home/user/project-master/build/src /home/user/project-master/build/src/CMakeFiles/sources.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/sources.dir/depend
