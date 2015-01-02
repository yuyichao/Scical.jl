set(scical_SRCS
  math.cpp)

add_library(scical SHARED ${scical_SRCS})

# target_link_libraries(scical)

set_target_properties(scical PROPERTIES
  COMPILE_FLAGS "-fvisibility=hidden"
  LINK_FLAGS "-Wl,--no-undefined"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  PREFIX ""
  OUTPUT_NAME "_scical")

install(TARGETS scical DESTINATION "${JULIA_LIB_PATH}")
