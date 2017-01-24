#Read Me
---
##Source Management
To add source files to an existing executable:
+ Include the `.c`/`.cc`/`.cxx`/`.cpp` files in `src/`
+ Add these files to the existing source files list in `src/CMakeLists.txt` like so:
```
add_library(sources Foo.cpp Bar.cpp NewFile.cpp)
```
+ Include the `.h`/`.hpp` files in `inc/`
+ Make sure the file is included in all necessary associated files using `#include "example.hpp"`

To add an executable (for testing purposes):
+ Add the `.c`/`.cc`/`.cxx`/`.cpp` file to `examples/`. This file must contain `int main()`
+ Add the following lines to `example/CMakeLists.txt` using your chosen executable name and the source file name:
```
add_executable(executable_name SourceFileName.cpp)
target_link_libraries(executable_name ${EXTRA_LIBS})
```

##Build Procedure
+ Open a terminal in `build/`
+ When significant changes have been made (such as adding/removing files or executables),  and issue the following commands:
```
rm -rf *
cmake ..
make clean
make
```
+ Otherwise, simply run `make`

The executable will appear in the build directory respective to the location of the source file containing `int main()` (e.g. an executable for `example/DetectionTest.cpp` will be added to `build/example/`)

