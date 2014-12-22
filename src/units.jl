# Copyright (C) 2012~2014 by Yichao Yu
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

__prefixes = [("Y", "yotta", 1e24), ("Z", "zetta", 1e21), ("E", "exa", 1e18),
              ("P", "peta", 1e15), ("T", "tera", 1e12), ("G", "giga", 1e9),
              ("M", "mega", 1e6), ("k", "kilo", 1e3), ("h", "hecto", 1e2),
              ("D", "deka", 1e1), ("", "", 1.0), ("d", "deci", 1e-1),
              ("c", "centi", 1e-2), ("m", "milli", 1e-3),
              ("u", "micro", 1e-6), ("n", "nano", 1e-9),
              ("p", "pico", 1e-12), ("f", "femto", 1e-15), ("a", "atto", 1e-18),
              ("z", "zepto", 1e-21)]

macro _def_scaled_units(baseval, basesym::String, basename::String)
    ex = quote
    end
    for (presym, prename, preval) in __prefixes
        if !isempty(basesym)
            sym = "$presym$basesym"
        elseif isempty(prename) || isempty(presym)
            continue
        else
            sym = prename
        end
        if isempty(prename)
            name = basename
        elseif isempty(basename)
            name = prename
        else
            name = "$prename $basename"
        end
        push!(ex.args, quote
              @phy_const $(esc(Symbol(sym))) $name ($preval * $baseval)
              end)
    end
    return ex
end

@_def_scaled_units 1 "" ""

@_def_scaled_units E "eV" "electron volt"
@_def_scaled_units E / c^2 "eVm" "electron volt mass"
@_def_scaled_units E / h "eVf" "electron volt frequency"
@_def_scaled_units E / k_B "eVT" "electron volt temperature"

@_def_scaled_units 1 "Hz" "Hertz"
@_def_scaled_units h / k_B "HzT" "Hertz temperature"
@_def_scaled_units h / c^2 "Hzm" "Hertz mass"

@_def_scaled_units 1 "K" "Kelvin"
@_def_scaled_units k_B / h "Kf" "Kelvin frequency"

@_def_scaled_units 1 "m" "meter"
@_def_scaled_units 1 "s" "second"
@_def_scaled_units 1e-3 "g" "gram"
@_def_scaled_units 1 "Pa" "Pascal"
@_def_scaled_units 1e-3 "L" "liter"

@phy_const D "Debye" 1e-21 / c

@phy_const ft "foot" 0.3048
@phy_const inch "inch" 25.4e-3
@phy_const yd "yard" 3 * ft
@phy_const mile "mile" 5280 * ft

@phy_const minute "minute" 60.
@phy_const hour "hour" 3600.
@phy_const day "day" 24 * hour
@phy_const week "week" 7 * day
@phy_const month "month" 30 * day
@phy_const yr "year" 365 * day

@phy_const bar "bar" 1e5
@phy_const pound "pound" 0.45359237
@phy_const psi "pound per square inche" pound / inch^2

@phy_const mmHg "millimeter mercury pressure" 13.5951 * g_0
@const_alias torr mmHg

@phy_const light_year "light year" c * year
@const_alias ly light_year

@phy_const Julian_year "Julian year" 31557600.0
