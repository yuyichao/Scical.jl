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

immutable PhyConst <: Real
    v::Float64
    name::String
end

const PhyConsts = Dict{String, PhyConst}()

function show(io::IO, x::PhyConst)
    return print(io, "$(x.name) = $(x.v)")
end

promote_rule(::Type{PhyConst}, ::Type{Float32}) = Float64

promote_rule(::Type{PhyConst}, ::Type{PhyConst}) = Float64

promote_rule{T<:Number}(::Type{PhyConst}, ::Type{T}) = promote_type(Float64, T)

convert(::Type{FloatingPoint}, x::PhyConst) = convert(FloatingPoint, x.v)
convert{T<:Union(Float16, Float32, Float64)}(::Type{T},
                                             x::PhyConst) = convert(T, x.v)
convert{T<:Real}(::Type{Complex{T}},
                 x::PhyConst) = convert(Complex{T}, x.v)

convert{T<:Integer}(::Type{Rational{T}},
                    x::PhyConst) = convert(Rational{T}, x.v)

==(x1::PhyConst, x2::PhyConst) = (x1.v == x2.v)

hash(x::PhyConst, h::UInt) = hash(x.v, h)

-(x::PhyConst) = -x.v
for op in Symbol[:+, :-, :*, :/, :^]
    @eval $op(x::PhyConst, y::PhyConst) = $op(x.v, y.v)
end

macro const_alias(new_name, orig_name)
    return quote
        const $(esc(new_name)) = $(esc(orig_name))
        $(esc(Expr(:export, new_name)))
    end
end

macro phy_const(sym, name, val)
    esym = esc(sym)
    def_alias = if Base.isidentifier(name) && name != string(sym)
        quote
            @const_alias $(Symbol(name)) $esym
        end
    else
        esc(Expr(:export, sym))
    end
    return quote
        const $esym = PhyConst(float($val), $name)
        $def_alias
        PhyConsts[$name] = $esym
    end
end

big(x::PhyConst) = convert(BigFloat, x)

# Align along = for nice Array printing
function Base.alignment(x::PhyConst)
    m = match(r"^(.*?)(=.*)$", sprint(Base.showcompact_lim, x))
    m == nothing ? (length(sprint(Base.showcompact_lim, x)), 0) :
    (length(m.captures[1]), length(m.captures[2]))
end
