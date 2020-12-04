if(${PROJECT_NAME}_ENABLE_CONAN)

  if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
    message(
      STATUS
        "Downloading conan.cmake from https://github.com/conan-io/cmake-conan..."
    )
    file(DOWNLOAD "https://github.com/conan-io/cmake-conan/raw/v0.15/conan.cmake"
                  "${CMAKE_BINARY_DIR}/conan.cmake"
                  TLS_VERIFY ON
    )
    message(STATUS "Cmake-Conan downloaded succesfully.")
  endif()

  include(${CMAKE_BINARY_DIR}/conan.cmake)

  conan_add_remote(
    NAME
      bincrafters
    URL
      https://api.bintray.com/conan/bincrafters/public-conan
  )

  conan_cmake_run(
    REQUIRES
      gtest/1.10.0
	  fmt/7.1.2
    # OPTIONS
    #   ${CONAN_OPTIONS}
    BASIC_SETUP
      CMAKE_TARGETS # Individual targets to link to
    BUILD
      missing
  )

  cmake_print_variables(CONAN_LIBS)
  # target_link_libraries(${PROJECT_NAME} ${CONAN_LIBS})

  verbose_message("Conan is setup and all requires have been installed.")
endif()

