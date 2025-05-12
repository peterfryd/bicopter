function [T_L, T_R, theta_L, theta_R] = solve_bicopter(Fx_des, Fz_des, Tau_x_des, Tau_z_des)

    L = 0.5;  % motor spacing
    h = 0.2;  % motor height offset

    x0 = [5; 5; 0; 0];  % [T_L, T_R, theta_L, theta_R]
    lb = [0; 0; -pi/2; -pi/2];
    ub = [100; 100; pi/2; pi/2];

    % Constraint function as a function handle
    constraints = @(x) [
        x(1)*sin(x(3)) + x(2)*sin(x(4)) - Fx_des;
        -(x(1)*cos(x(3)) + x(2)*cos(x(4))) - Fz_des;
        h * (x(2)*cos(x(4)) - x(1)*cos(x(3))) - Tau_x_des;
        (L/2) * (x(1)*sin(x(3)) - x(2)*sin(x(4))) - Tau_z_des
    ];

    % Wrap constraints to return nonlinear equalities
    nonlcon = @(x) deal([], constraints(x));

    % Use fmincon with the SQP algorithm
    options = optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp');
    [x, ~, exitflag] = fmincon(@(x) 0, x0, [], [], [], [], lb, ub, nonlcon, options);

    if exitflag > 0
        T_L = x(1);
        T_R = x(2);
        theta_L = x(3);
        theta_R = x(4);
    else
        T_L = 0;
        T_R = 0;
        theta_L = 0;
        theta_R = 0;
    end
end
