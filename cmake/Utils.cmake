
function(verbose_message content)
    if(${PROJECT_NAME}_VERBOSE_OUTPUT)
			message(STATUS ${content})
    endif()
endfunction()
