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

module at_m

using Scical

macro _atom_mass(sym, name::String, val)
    name = "$name atom mass"
    quote
        @phy_const $(esc(sym)) $name $(esc(val))
    end
end

@_atom_mass H "Hydrogen" 1.00794  # average
@_atom_mass H1 "Hydrogen 1" 1.00782503207
@_atom_mass H2 "Hydrogen 2" 2.0141017779
@_atom_mass D "Deuterium" 2.0141017779
@_atom_mass H3 "Hydrogen 3" 3.0160492777
@_atom_mass T "Tritium" 3.0160492777

@_atom_mass He "Helium" 4.002602
@_atom_mass Li "Lithium" 6.941
@_atom_mass Be "Beryllium" 9.012182
@_atom_mass B "Boron" 10.811
@_atom_mass C "Carbon" 12.011
@_atom_mass N "Nitrogen" 14.00674
@_atom_mass O "Oxygen" 15.9994
@_atom_mass F "Fluorine" 18.9984
@_atom_mass Ne "Neon" 20.1797
@_atom_mass Na "Sodium" 22.98977
@_atom_mass Mg "Magnesium" 24.305
@_atom_mass Al "Aluminium" 26.98154
@_atom_mass Si "Silicon" 28.0855
@_atom_mass P "Phosphorus" 30.97376
@_atom_mass S "Sulfur" 32.066
@_atom_mass Cl "Chlorine" 35.4527
@_atom_mass Ar "Argon" 39.948
@_atom_mass K "Potassium" 39.0983
@_atom_mass Ca "Calcium" 40.078
@_atom_mass Sc "Scandium" 44.95591
@_atom_mass Ti "Titanium" 47.88
@_atom_mass V "Vanadium" 50.9415
@_atom_mass Cr "Chromium" 51.9961
@_atom_mass Mn "Manganese" 54.93805
@_atom_mass Fe "Iron" 55.847
@_atom_mass Co "Cobalt" 58.9332
@_atom_mass Ni "Nickel" 58.6934
@_atom_mass Cu "Copper" 63.546
@_atom_mass Zn "Zinc" 65.39
@_atom_mass Ga "Gallium" 69.723
@_atom_mass Ge "Germanium" 72.61
@_atom_mass As "Arsenic" 74.92159
@_atom_mass Se "Selenium" 78.96
@_atom_mass Br "Bromine" 79.904
@_atom_mass Kr "Krypton" 83.8
@_atom_mass Rb "Rubidium" 85.4678
@_atom_mass Sr "Strontium" 87.62
@_atom_mass Y "Yttrium" 88.90585
@_atom_mass Zr "Zirconium" 91.224
@_atom_mass Nb "Niobium" 92.90638
@_atom_mass Mo "Molybdenum" 95.94
@_atom_mass Tc "Technetium" 98
@_atom_mass Ru "Ruthenium" 101.07
@_atom_mass Rh "Rhodium" 102.9055
@_atom_mass Pd "Palladium" 106.42
@_atom_mass Ag "Silver" 107.8682
@_atom_mass Cd "Cd" 112.411
@_atom_mass In "In" 114.818
@_atom_mass Sn "Sn" 118.71
@_atom_mass Sb "Sb" 121.757
@_atom_mass I "I" 126.9045
@_atom_mass Te "Te" 127.6
@_atom_mass Xe "Xe" 131.29
@_atom_mass Cs "Cs" 132.9054
@_atom_mass Ba "Ba" 137.327
@_atom_mass La "La" 138.9055
@_atom_mass Ce "Ce" 140.115
@_atom_mass Pr "Pr" 140.9077
@_atom_mass Nd "Nd" 144.24
@_atom_mass Pm "Pm" 145
@_atom_mass Sm "Sm" 150.36
@_atom_mass Eu "Eu" 151.965
@_atom_mass Gd "Gd" 157.25
@_atom_mass Tb "Tb" 158.9253
@_atom_mass Dy "Dy" 162.5
@_atom_mass Ho "Ho" 164.9303
@_atom_mass Er "Er" 167.26
@_atom_mass Tm "Tm" 168.9342
@_atom_mass Yb "Yb" 173.04
@_atom_mass Lu "Lu" 174.967
@_atom_mass Hf "Hf" 178.49
@_atom_mass Ta "Ta" 180.9479
@_atom_mass W "W" 183.85
@_atom_mass Re "Re" 186.207
@_atom_mass Os "Os" 190.2
@_atom_mass Ir "Ir" 192.22
@_atom_mass Pt "Pt" 195.08
@_atom_mass Au "Au" 196.9665
@_atom_mass Hg "Hg" 200.59
@_atom_mass Tl "Tl" 204.3833
@_atom_mass Pb "Pb" 207.2
@_atom_mass Bi "Bi" 208.9804
@_atom_mass Po "Po" 208.9824
@_atom_mass At "At" 209.9871
@_atom_mass Pa "Pa" 213.0359
@_atom_mass Rn "Rn" 222
@_atom_mass Fr "Fr" 223
@_atom_mass Ra "Ra" 226.0254
@_atom_mass Ac "Ac" 227.0728
@_atom_mass Th "Th" 232.0381
@_atom_mass Np "Np" 237.0482
@_atom_mass U "U" 238.0289
@_atom_mass Am "Am" 243.0614
@_atom_mass Pu "Pu" 244.0642
@_atom_mass Cm "Cm" 247
@_atom_mass Bk "Bk" 247
@_atom_mass Cf "Cf" 251
@_atom_mass Es "Es" 252
@_atom_mass Fm "Fm" 257
@_atom_mass Md "Md" 258
@_atom_mass No "No" 259
@_atom_mass Lr "Lr" 260
@_atom_mass Rf "Rf" 261
@_atom_mass Db "Db" 262
@_atom_mass Bh "Bh" 262
@_atom_mass Sg "Sg" 263
@_atom_mass Hs "Hs" 265
@_atom_mass Mt "Mt" 266
@_atom_mass Ds "Ds" 271
@_atom_mass Rg "Rg" 272

end
