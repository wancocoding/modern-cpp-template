cmake_minimum_required(VERSION 3.12 FATAL_ERROR)


project(Learn
		VERSION 1.0.1
        DESCRIPTION "My Cpp project template"
		LANGUAGES CXX
)

include(CMakePrintHelpers)
include(cmake/BuildOptions.cmake)
include(cmake/Utils.cmake)

message(STATUS "Started CMake for ${PROJECT_NAME} v${PROJECT_VERSION}...\n")

# ---- Add source files ----

# Note: globbing sources is considered bad practice as CMake's generators may not detect new files
# automatically. Keep that in mind when changing files, or explicitly mention them here.
file(GLOB_RECURSE headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h")
file(GLOB_RECURSE sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/source/*.cpp")

set(SOURCES
    src/Hello.cpp
    src/main.cpp
)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_BUILD_TYPE "Debug")

# Set a default build type if none was specified
# if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
#   message("Setting build type to 'RelWithDebInfo' as none was specified.")
#   set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
#   # Set the possible values of build type for cmake-gui
#   set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
#     "MinSizeRel" "RelWithDebInfo")
# endif()

add_executable(Learn ${SOURCES})

# cmake_print_variables(SOURCES)

# Set the directories that should be included in the build command for this target
# when running g++ these will be included as -I/directory/path/
target_include_directories(Learn
    PRIVATE 
        ${PROJECT_SOURCE_DIR}/include
)

# vim:set et sts=4 sw=4 ts=4 tw=79 ft=cmake: 
