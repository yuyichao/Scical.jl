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
@_include_sub optics

using Class

export compose_g, compose_gJ, compose_gF

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

export sideband_strength, sideband_scatter_strength

function sideband_strength(n1::Real, n2::Real, eta::Real)
    return _ffi_harmonic_recoil(n1, n2, eta)
end

function sideband_scatter_strength(n1::Real, n2::Real, eta::Real, theta0::Real)
    return _ffi_harmonic_scatter(n1, n2, eta, theta0)
end

export Transition

@class Transition begin
    __freq::Float64
    __dipole::Float64

    function __class_init__(self, kws::Dict{Symbol, Any})
        if haskey(kws, :freq)
            self.__freq = pop!(kws, :freq)
        elseif haskey(kws, :lamb)
            self.__freq = c_0 / pop!(kws, :lamb)
        else
            error("no arguments to initialize frequency")
        end
        if haskey(kws, :dipole)
            self.__dipole = pop!(kws, :dipole)
        else
            error("no arguments to initialize dipole moment")
        end
        if !isempty(kws)
            error("too many arguments to initialize Transition")
        end
    end

    function __class_init__(self; _kws...)
        self.__class_init__(Dict{Symbol, Any}(_kws))
    end

    function omega(self)
        return self.__freq * 2 * π
    end

    function freq(self)
        return self.__freq
    end

    function lamb(self)
        return c_0 / self.__freq
    end

    function dipole(self)
        return self.__dipole
    end

    function ac_stark(self, freq::Real, I::Real=1.):
        return -(self.__dipole^2 * I / ħ / c_0 / ϵ_0 / 4 / π
                 * (1 / (self.__freq - freq) + 1 / (self.__freq + freq)))
    end
end

export ODT

@class ODT <: optics.Focus begin
    __trans::Array{Transition}
    __P::Float64
    __m::Float64
    function __class_init__(self, trans, power::Real, mass::Real; kws...)
        @method_chain __class_init__(self; kws...)
        self.__trans = Transition[trans...]
        self.__P = power
        self.__m = mass
    end
    function __class_init__(self, trans::Transition, power::Real,
                            mass::Real; kws...)
        @method_chain __class_init__(self; kws...)
        self.__trans = Transition[trans]
        self.__P = power
        self.__m = mass
    end

    function __ac_stark(self, I::Real=1)
        return sum(self.__trans) do t
            t.ac_stark(self.freq(), I)
        end
    end

    function power(self)
        return self.__P
    end

    function focus_I(self)
        return self.focus_I(self, self.__P)
    end

    function depth(self)
        return self.__ac_stark(self.focus_I())
    end

    function depth_f(self)
        return self.depth() / h
    end

    function depth_omega(self)
        return self.depth() / ħ
    end

    function trap_omega_l(self)
        return 2 / self.radius_l() * sqrt(self.depth() / self.__m)
    end

    function trap_omega_r(self)
        return 2 / self.radius_r() * sqrt(self.depth() / self.__m)
    end

    function trap_freq_l(self)
        return self.trap_omega_l() / (2π)
    end

    function trap_freq_r(self)
        return self.trap_omega_r() / (2π)
    end

    function z0_l(self)
        return sqrt(ħ / 2 / self.__m / self.trap_omega_l())
    end

    function z0_r(self)
        return sqrt(ħ / 2 / self.__m / self.trap_omega_r())
    end

    function eta_l(self, lamb)
        return 2π / lamb * self.z0_l()
    end

    function eta_r(self, lamb)
        return 2π / lamb * self.z0_r()
    end

    function nmax_r(self)
        return self.depth_f() / self.trap_freq_r() / 2
    end

    function nmax_l(self)
        return self.depth_f() / self.trap_freq_l() / 2
    end
end
