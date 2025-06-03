% function [T_L, T_R, theta_L, theta_R] = solve_bicopter(Fy_des, Fz_des, Tau_x_des, Tau_z_des)
% 
%     L = 0.5;  % motor spacing along y-axis (arm length)
%     h = 0.2;  % height offset along z-axis
% 
%     % Initial guess: [T_L, T_R, theta_L, theta_R]
%     x0 = [5; 5; 0; 0];
%     lb = [0; 0; -pi/2; -pi/2];
%     ub = [1000; 1000; pi/2; pi/2];
% 
%     % Constraints: force and torque balance
%     constraints = @(x) [
%         x(1)*sin(x(3)) + x(2)*sin(x(4)) - Fy_des;                 % Net force in y
%         -(x(1)*cos(x(3)) + x(2)*cos(x(4))) - Fz_des;              % Net force in z (NED convention: z down)
%         h * (x(2)*cos(x(4)) - x(1)*cos(x(3))) - Tau_x_des;        % Roll torque
%         (L/2) * (x(1)*sin(x(3)) - x(2)*sin(x(4))) - Tau_z_des     % Yaw torque
%     ];
% 
%     nonlcon = @(x) deal([], constraints(x));
% 
%     options = optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp');
%     [x, ~, exitflag] = fmincon(@(x) 0, x0, [], [], [], [], lb, ub, nonlcon, options);
% 
%     if exitflag > 0
%         T_L = x(1);  T_R = x(2);
%         theta_L = x(3); theta_R = x(4);
%     else
%         T_L = 0; T_R = 0;
%         theta_L = 0; theta_R = 0;
%     end
% end


function [T1, T2, delta1, delta2] = solve_bicopter(Fz_des, Tau_x_des, Tau_y_des, Tau_z_des)

    L = 0.5;  % spacing along x-axis (full length is 2L)
    D = 0.2;  % height from rotor to CoM

    % Initial guess: [T1, T2, delta1, delta2]
    x0 = [5; 5; 0; 0];
    lb = [-10000; -10000; -pi/3; -pi/3];
    ub = [0; 0; pi/3; pi/3];

    % Constraint equations based on tilt in Y-Z plane
    constraints = @(x) [
        x(1)*cos(x(3)) + x(2)*cos(x(4)) - Fz_des;
        D*x(1)*sin(x(3)) + D*x(2)*sin(x(4)) - Tau_x_des;
        L*x(1)*cos(x(3)) - L*x(2)*cos(x(4)) - Tau_y_des;
        L*x(1)*sin(x(3)) - L*x(2)*sin(x(4)) - Tau_z_des;
    ];

    nonlcon = @(x) deal([], constraints(x));

    options = optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp');
    [x, ~, exitflag] = fmincon(@(x) 0, x0, [], [], [], [], lb, ub, nonlcon, options);

    if exitflag > 0
        T1 = x(1);  T2 = x(2);
        delta1 = x(3); delta2 = x(4);
    else
        T1 = 0; T2 = 0;
        delta1 = 0; delta2 = 0;
    end
end
