#

set(Scical_SRCS
  Scical.jl)

cmake_utils_install_files("${julia_path}/Scical/src"
  FILES: ${Scical_SRCS})
