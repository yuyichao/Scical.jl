#

set(Scical_SRCS
  Scical.jl
  formatter.jl
  _const.jl
  units.jl
  atomic.jl
  _ffi.jl
  phy_const.jl
  optics.jl
  astro.jl
  atom_mass.jl)

cmake_utils_install_files("${julia_path}/Scical/src"
  FILES: ${Scical_SRCS})
