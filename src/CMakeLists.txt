foreach (CATCH_INCLUDE_SUBDIR catch catch2)
  configure_file(cet_catch_main.cpp.in
    ${CMAKE_CURRENT_BINARY_DIR}/cet_${CATCH_INCLUDE_SUBDIR}_main.cpp
    @ONLY
    )
endforeach()
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/cet_catch_main.cpp
  ${CMAKE_CURRENT_BINARY_DIR}/cet_catch2_main.cpp
  DESTINATION
  src
  )
