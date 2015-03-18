# Copyright (C) 2014~2014 by Yichao Yu
# yyc1992@gmail.com
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

@_init_func function ()
    global const _scical_lib = Libdl.dlopen("_scical")
end

function _ffi_genlaguerre(n::Real, m::Real, x::Real)
    return ccall((:genlaguerre, _scical_lib), Cdouble,
                 (Cuint, Cuint, Cdouble), n, m, x)
end

function _ffi_harmonic_recoil(n::Real, m::Real, eta::Real)
    return ccall((:harmonic_recoil, _scical_lib), Cdouble,
                 (Cuint, Cuint, Cdouble), n, m, eta)
end

function _ffi_harmonic_scatter(n::Real, m::Real, eta::Real, theta::Real)
    return ccall((:harmonic_scatter, _scical_lib), Cdouble,
                 (Cuint, Cuint, Cdouble, Cdouble), n, m, eta, theta)
end
