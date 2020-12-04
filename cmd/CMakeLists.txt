cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

project(
  ${CMAKE_PROJECT_NAME}Standalone
    LANGUAGES CXX
)
file(GLOB_RECURSE exe_sources CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

add_executable(${PROJECT_NAME} ${exe_sources})

# target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
set_target_properties(
  ${PROJECT_NAME}
    PROPERTIES CXX_STANDARD 17 
    OUTPUT_NAME ${CMAKE_PROJECT_NAME}
)

target_link_libraries(
  ${PROJECT_NAME}
	${CMAKE_PROJECT_NAME}
)

