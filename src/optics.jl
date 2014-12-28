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

module optics

export Focus

using Class
using Scical

@class Focus begin
    __fnum::Float64
    __lamb::Float64

    function __init_theta(self, sin_t::Real)
        self.__fnum = sqrt(1 / sin_t^2 - 1)
    end

    function __class_init__(self, kws::Dict{Symbol, Any})
        if haskey(kws, :lamb)
            self.__lamb = pop!(kws, :lamb)
        end

        if haskey(kws, :fnum)
            self.__fnum = pop!(kws, :fnum)
        elseif haskey(kws, :NA)
            sin_t = pop!(kws, :NA) / pop!(kws, :n, 1)
            self.__init_theta(sin_t)
        elseif haskey(kws, :theat)
            self.__init_theta(sin(pop!(kws, :theta)))
        else
            error("no arguments to initialize Focus")
        end

        if !isempty(kws)
            error("too many arguments to initialize Focus")
        end
    end

    function __class_init__(self; _kws...)
        self.__class_init__(Dict{Symbol, Any}(_kws))
    end

    function focus_I(self, P::Real)
        # Intensity at the center of the focus with power P.
        return P * π / (self.__lamb * self.__fnum)^2
    end

    function quad_r(self)
        # Comes from the expension of (2 * J_1(v) / v)**2
        # where v = 2 * pi / lambda / f# * r
        return (π / self.__lamb / self.__fnum)^2
    end

    function quad_l(self)
        # Comes from the expension of (sin(u / 4) / (u / 4))**2
        # where u = 2 * pi / lambda / f#**2 * z
        return (π / self.__lamb / self.__fnum^2)^2 / 12
    end

    function radius_r(self)
        return sqrt(2) * self.__lamb * self.__fnum / π
    end

    function radius_l(self)
        return 2 * sqrt(6) * self.__lamb * self.__fnum^2 / π
    end

    function lamb(self)
        return self.__lamb
    end

    function freq(self)
        return c_0 / self.__lamb
    end

    function fnum(self)
        return self.__fnum
    end
end

end
