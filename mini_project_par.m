clc, clear close all

m = 2; % Mass in kg
g = 9.81; % Gravity constant

L = 0.5;  % Spacing along x-axis (full length is 2L)
D = 0.2;  % Height from rotor to CoM

% Inertia matrix
Ic = diag([ 2 ; 2 ; 4 ]);

% Rigid-body mass matrix
M_RB = [ m*eye(3) , zeros(3) ; zeros(3) , Ic ];


% Limits in motor thrusts (N) and servo angles (rad)
% Note that upwards thrust is negative (NED convention)
delta_limits = [-pi/3; pi/3];
T_limits = [-1000, 0];

% List of params for Simulink
params = [m, g, L, D, delta_limits(1), delta_limits(2), T_limits(1), T_limits(2)];