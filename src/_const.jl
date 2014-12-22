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

@_include_sub phy_const

@phy_const c "Speed of light in vaccum" 299792458.0
@const_alias c_0 c
@phy_const mu_0 "Vacuum permeability" 4π * 1e-7
@const_alias μ_0 mu_0
@phy_const epsilon_0 "Vacuum permittivity" 1 / μ_0 / c^2
@const_alias ɛ_0 epsilon_0

@phy_const E "Elementary charge" 1.602176565e-19
@const_alias e_0 E
@phy_const h "Planck constant" 6.62606957e-34
@phy_const hbar "Reduced Planck constant" h / (2π)
@const_alias ħ hbar
@phy_const alpha "Fine structure constant" 0.0072973525698
@const_alias α alpha
@phy_const Rydberg "Rydberg constant" 10973731.568539
@const_alias R_inf Rydberg

@phy_const Z_0 "characteristic impedance of vacuum" μ_0 * c_0
@phy_const k_e "Coulomb constant" 1 / (4π * ɛ_0)
@phy_const G_0 "Conductance quantum" 2 * E^2 / h

@phy_const G "Gravitational constant" 6.67384e-11
@const_alias G_N G
@phy_const g_0 "Standard gravity" 9.80665

@phy_const R "Ideal gas constant" 8.3144621
@phy_const N_A "Avogadro constant" 6.02214129e+23
@phy_const k_B "Boltzmann constant" 1.3806488e-23
@phy_const sigma "Stefan-Boltzmann constant" 5.670373e-08
@const_alias σ sigma
@phy_const b_wien "Wien wavelength displacement law constant" 0.0028977721

@phy_const K_J "Josephson constant" 2 * E / h
@phy_const R_K "von Klitzing constant" h / E^2
@phy_const phi_0 "magnetic flux quantum" h / (2 * E)
@const_alias φ_0 phi_0
@phy_const F_c "Faraday constant" N_A * E

@phy_const m_e "Electron mass" 9.10938291e-31
@phy_const m_n "Neutron mass" 1.674927351e-27
@phy_const m_p "Proton mass" 1.672621777e-27
@phy_const a_0 "Bohr radius" α / (4π * R_inf)
@phy_const r_e "Classical electron radius" E^2 / (4π * ɛ_0 * m_e * c^2)
@phy_const E_h "Hartree" 2 * R_inf * h * c

@phy_const g_e "Electron g factor" 2.00231930436153
@phy_const g_n "Neutron g factor" -3.82608545
@phy_const g_p "Proton g factor" 5.585694713

@phy_const mu_B "Bohr magneton" E * ħ / (2 * m_e)
@phy_const mu_N "Nuclear magneton" E * ħ / (2 * m_p)
@phy_const mu_Bf "Bohr magneton frequency" mu_B / h
@phy_const mu_Nf "Nuclear magneton frequency" mu_N / h

@phy_const l_P "Planck length" ħ * G_N / c^3
@phy_const m_P "Planck mass" sqrt(ħ * c / G_N)
@phy_const E_P "Planck energy" m_P * c^2
@phy_const t_P "Planck time" l_P / c
@phy_const q_P "Planck charge" sqrt(4π * ɛ_0 * ħ * c)
@phy_const T_P "Planck temperature" E_P / k_B
