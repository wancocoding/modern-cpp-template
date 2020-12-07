cmake_minimum_required(VERSION 3.15)


project(
  ${CMAKE_PROJECT_NAME}Tests
  LANGUAGES CXX
)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

verbose_message("Adding tests under ${CMAKE_PROJECT_NAME}Tests...")

file(GLOB_RECURSE test_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

add_executable(${PROJECT_NAME} ${test_sources})

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)

# if (${CMAKE_PROJECT_NAME}_ENABLE_CODE_COVERAGE)
#   target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -O0 -g -fprofile-arcs -ftest-coverage)
#   target_link_options(${CMAKE_PROJECT_NAME} PUBLIC -fprofile-arcs -ftest-coverage)
#   verbose_message("Code coverage is enabled and provided with GCC.")
# endif()

#
# Load the desired unit testing framework
#
# Currently supported: GoogleTest (and GoogleMock), Catch2.

# if(${CMAKE_PROJECT_NAME}_BUILD_EXECUTABLE)
# 	set(${CMAKE_PROJECT_NAME}_TEST_LIB ${CMAKE_PROJECT_NAME}_LIB)
# else()
# 	set(${CMAKE_PROJECT_NAME}_TEST_LIB ${CMAKE_PROJECT_NAME})
# endif()

if(${CMAKE_PROJECT_NAME}_USE_GTEST)
  find_package(GTest REQUIRED)

  if(${CMAKE_PROJECT_NAME}_USE_GOOGLE_MOCK)
		set(GOOGLE_MOCK_LIBRARIES GTest::gmock GTest::gmock_main)
  endif()

  target_link_libraries(
    ${PROJECT_NAME} 
    PUBLIC
      GTest::GTest
      GTest::Main
      ${GOOGLE_MOCK_LIBRARIES}
      ${CMAKE_PROJECT_NAME}
  )
elseif(${CMAKE_PROJECT_NAME}_USE_CATCH2)
  find_package(Catch2 REQUIRED)
  target_link_libraries(
    ${PROJECT_NAME} 
    PUBLIC
      Catch2::Catch2
      ${CMAKE_PROJECT_NAME}
  )
else()
  message(FATAL_ERROR "Unknown testing library. Please setup your desired unit testing library by using `target_link_libraries`.")  
endif()

#
# Add the unit tests
#

add_test(
  NAME
    ${PROJECT_NAME}
  COMMAND
    ${PROJECT_NAME}
)

if (${CMAKE_PROJECT_NAME}_ENABLE_CODE_COVERAGE)
  target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC -O0 -g -fprofile-arcs -ftest-coverage)
  target_link_options(${CMAKE_PROJECT_NAME} PUBLIC -fprofile-arcs -ftest-coverage)
  verbose_message("Code coverage is enabled and provided with GCC.")
endif()

verbose_message("Finished adding unit tests for ${CMAKE_PROJECT_NAME}.")
