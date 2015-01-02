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

module Scical

function _convert_mod_path(mod::Symbol)
    return string(mod)
end

function _convert_mod_path(mod::Expr)
    if mod.head != :(.)
        error("Invalid module path.")
    end
    return string(_convert_mod_path(mod.args[1]), "/", mod.args[2])
end

const _included_files = Set{String}()

macro _include_sub(mod)
    mod_path = string(_convert_mod_path(mod), ".jl")
    cur_file = current_module().eval(:(@__FILE__))
    full_path = abspath(joinpath(dirname(cur_file), mod_path))
    if full_path in _included_files
        nothing
    else
        push!(_included_files, full_path)
        Expr(:call, include, mod_path)
    end
end

const _init_hooks = Any[]

function __init__()
    for f in _init_hooks
        f()
    end
end

macro _init_func(ex)
    quote
        push!(_init_hooks, ($(esc(ex))))
    end
end

@_include_sub formatter
@_include_sub _const
@_include_sub units
@_include_sub optics
@_include_sub atomic
@_include_sub astro
@_include_sub atom_mass

end
