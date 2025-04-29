clc, clear close all
m = 0.725;     % kg
g = 9.82;     % m/s^2
h = 0.042;    % m
L = 0.225;    % m
Ct = 0.1222;    % N*s^2/rad^2
Ixx = 0.116E-3;  % kg*m^2
Iyy = 0.0408E-3;  % kg*m^2
Izz = 0.105E-3;  % kg*m^2

omega_min = -100;
omega_max = 0;
zeta_min = -pi/2;
zeta_max = pi/2;

omega_pars = [omega_min, omega_max];
zeta_pars = [zeta_min, zeta_max];
params = [m, g, h L, Ct, Ixx, Iyy, Izz];