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

export @phy_const, PhyConsts

importall Base

abstract PhyConstBase <: Real

immutable PhyConst{T<:Real} <: PhyConstBase
    v::T
    name::String
end

const PhyConsts = Dict{String, PhyConstBase}()

function show(io::IO, x::PhyConstBase)
    return print(io, "$(x.name) = $(x.v)")
end

promote_rule{T}(::Type{PhyConst{T}},
                ::Type{Float32}) = promote_type(T, Float32)

promote_rule{T1, T2}(::Type{PhyConst{T1}},
                     ::Type{PhyConst{T2}}) = promote_type(T1, T2)

promote_rule{T1, T2<:Number}(::Type{PhyConst{T1}},
                             ::Type{T2}) = promote_type(T1, T2)

convert{T<:Union(Float16, Float32, Float64)}(::Type{T},
                                             x::PhyConstBase) = convert(T, x.v)

convert{T<:Real}(::Type{Complex{T}},
                 x::PhyConstBase) = convert(Complex{T}, x.v)

convert{T<:Integer}(::Type{Rational{T}},
                    x::PhyConstBase) = convert(Rational{T}, x.v)

==(x1::PhyConstBase, x2::PhyConstBase) = (x1.v == x2.v)

hash(x::PhyConstBase, h::UInt) = hash(x.v, h)

-(x::PhyConstBase) = -x.v
for op in Symbol[:+, :-, :*, :/, :^]
    @eval $op(x::PhyConstBase, y::PhyConstBase) = $op(x.v, y.v)
end

macro const_alias(new_name, orig_name)
    return quote
        const $(esc(new_name)) = $(esc(orig_name))
        $(esc(Expr(:export, new_name)))
    end
end

macro phy_const(var, name, val)
    if !isa(val, Real)
        val = current_module().eval(val)
    end
    if !isa(val, FloatingPoint)
        val = float(val)
    end

    sym = Symbol(name)
    evar = esc(var)
    esym = esc(sym)
    qsym = esc(Expr(:quote, sym))
    str = "$name = $val"
    def_alias = if sym != var
        quote
            @const_alias $evar $esym
        end
    else
        esc(Expr(:export, sym))
    end
    return quote
        const $esym = PhyConst($val, $name)
        $def_alias
        PhyConsts[$name] = $esym
    end
end

big(x::PhyConstBase) = convert(BigFloat, x)

# Align along = for nice Array printing
function Base.alignment(x::PhyConstBase)
    m = match(r"^(.*?)(=.*)$", sprint(Base.showcompact_lim, x))
    m == nothing ? (length(sprint(Base.showcompact_lim, x)), 0) :
    (length(m.captures[1]), length(m.captures[2]))
end
