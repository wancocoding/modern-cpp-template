cmake_minimum_required(VERSION 3.15 FATAL_ERROR)


project(
  Hello
  VERSION 1.0.1
  DESCRIPTION "My Cpp project template"
  LANGUAGES CXX
)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there."
  )
endif()

include(CMakePrintHelpers)
include(cmake/BuildOptions.cmake)
include(cmake/Utils.cmake)

message(STATUS "Started CMake for ${PROJECT_NAME} v${PROJECT_VERSION}...\n")



# ---- Add dependencies via CPM ----
# see https://github.com/TheLartians/CPM.cmake for more info

# include(cmake/CPM.cmake)


# # PackageProject.cmake will be used to make our target installable
# CPMAddPackage(
#   NAME PackageProject.cmake
#   GITHUB_REPOSITORY TheLartians/PackageProject.cmake
#   VERSION 1.3
# )

# ---- Add package management ----
# use conan

include(cmake/Conan.cmake)

# ---- Add source files ----

# Note: globbing sources is considered bad practice as CMake's generators may not detect new files
# automatically. Keep that in mind when changing files, or explicitly mention them here.
file(GLOB_RECURSE headers CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h")
file(GLOB_RECURSE sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")


if(${PROJECT_NAME}_BUILD_HEADERS_ONLY)
  add_library(${PROJECT_NAME} INTERFACE)
else()
  add_library(${PROJECT_NAME} ${headers} ${sources})
endif()

#
# Set the project standard and warnings
#

if(${PROJECT_NAME}_BUILD_HEADERS_ONLY)
  target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_17)
else()
  target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
endif()
# set(CMAKE_CXX_STANDARD 17)

# set(CMAKE_BUILD_TYPE "Debug")

if(${PROJECT_NAME}_BUILD_HEADERS_ONLY)
  target_include_directories(
    ${PROJECT_NAME}
    INTERFACE 
      $<INSTALL_INTERFACE:include>
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  )
else()
  target_include_directories(
    ${PROJECT_NAME}
    PUBLIC 
      $<INSTALL_INTERFACE:include>
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
      ${CMAKE_CURRENT_SOURCE_DIR}/src
  )
endif()

# Identify and link with the specific "packages" the project uses
#find_package(package_name package_version REQUIRED package_type [other_options])

# find_package(fmt REQUIRED)
# target_link_libraries(
#   ${PROJECT_NAME}
  # PUBLIC
  #   CONAN_PKG::fmt
  # PRIVATE
  #   CONAN_PKG::fmt
  #   ${PROJECT_NAME}_PROJECT_OPTIONS        
  #   ${PROJECT_NAME}_PROJECT_WARNINGS        
# )

target_link_libraries(
  ${PROJECT_NAME} 
  # ${CONAN_LIBS}
    CONAN_PKG::fmt
)

message(STATUS "Finished setting up include directories.")

# target_include_directories(
#   ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
#                  $<INSTALL_INTERFACE:include/${PROJECT_NAME}-${PROJECT_VERSION}>
# )

# # Set a default build type if none was specified
# if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
#   message("Setting build type to 'RelWithDebInfo' as none was specified.")
#   set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
#   # Set the possible values of build type for cmake-gui
#   set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
#     "MinSizeRel" "RelWithDebInfo")
# endif()

cmake_print_variables(sources)
cmake_print_variables(headers)

# # Set the directories that should be included in the build command for this target
# # when running g++ these will be included as -I/directory/path/
# target_include_directories(Learn
#     PRIVATE 
#         ${PROJECT_SOURCE_DIR}/include
# )


if(${PROJECT_NAME}_BUILD_EXECUTABLE)
  add_subdirectory(cmd ${CMAKE_BINARY_DIR}/cmd)
endif()

# ========================
# Unit test
# ========================
if(${PROJECT_NAME}_ENABLE_UNIT_TESTING)
  enable_testing()
	message(STATUS "Build unit tests for the project. Tests should always be found in the test folder\n")
  add_subdirectory(test)
endif()

# vim:set et sts=2 sw=2 ts=2 tw=99 ft=cmake: 
