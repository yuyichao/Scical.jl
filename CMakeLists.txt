project(Scical.jl)

## Setup
cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}"
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(JuliaMacros)
include(CMakePathMacros)
include(CMakeCMacros)
include(GNUInstallDirs)

if(NOT DEFINED JULIA_LIB_PATH)
  set(JULIA_LIB_PATH "${CMAKE_INSTALL_LIBDIR}/julia")
endif()

if(NOT DEFINED JULIA_SITE_PATH)
  julia_site_path(julia_path)
else()
  set(julia_path "${JULIA_SITE_PATH}")
endif()

cmake_c_add_flags(CMAKE_C_FLAGS -Wall -Wextra -std=gnu99 -fopenmp)
cmake_c_add_flags(CMAKE_CXX_FLAGS -Wall -Wextra
  -Wno-deprecated-register -std=c++14 -fopenmp)
cmake_c_add_flags(CMAKE_SHARED_LINKER_FLAGS -Wl,--as-needed -Wl,--no-undefined)
cmake_c_add_flags(CMAKE_MODULE_LINKER_FLAGS -Wl,--as-needed -Wl,--no-undefined)

add_subdirectory(src)
add_subdirectory(lib)
