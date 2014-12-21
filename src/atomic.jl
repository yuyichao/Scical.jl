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

@_include_sub _const
@_include_sub _ffi

export compose_g, compose_gJ, compose_gF
export sideband_strength, sideband_scatter_strength

function compose_g(J_sum::Real, J1::Real, J2::Real, g1::Real, g2::Real)
    if J_sum == 0
        return 0.0
    end
    J_sum_2 = J_sum * (J_sum + 1)
    J1_2 = J1 * (J1 + 1)
    J2_2 = J2 * (J2 + 1)
    return (g1 * (J_sum_2 + J1_2 - J2_2) +
            g2 * (J_sum_2 + J2_2 - J1_2)) / 2 / J_sum_2
end

function compose_gJ(J::Real, L::Real, S::Real)
    return compose_g(J, L, S, 1.0, g_e)
end

function compose_gF(F::Real, I::Real, J::Real, L::Real, S::Real, g_I::Real=0.0)
    return compose_g(F, I, J, g_I, compose_gJ(J, L, S))
end

function sideband_strength(n1, n2, eta)
    return _ffi_harmonic_recoil(n1, n2, eta)
end

function sideband_scatter_strength(n1, n2, eta, theta0)
    return _ffi_harmonic_scatter(n1, n2, eta, theta0)
end
