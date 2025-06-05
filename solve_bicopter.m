function [T1, T2, delta1, delta2] = solve_bicopter(Fz_des, Tau_x_des, Tau_y_des, Tau_z_des, L, D, T_min, delta_min, T_max, delta_max)

    % Initial guess: [T1, T2, delta1, delta2]
    x0 = [5; 5; 0; 0];
    lb = [T_min; T_min; delta_min; delta_min];
    ub = [T_max; T_max; delta_max; delta_max];

    % Objective: minimize the squared error of all constraints
    objective = @(x) sum([
        x(1)*cos(x(3)) + x(2)*cos(x(4)) - Fz_des;
        D*x(1)*sin(x(3)) + D*x(2)*sin(x(4)) - Tau_x_des;
        L*x(1)*cos(x(3)) - L*x(2)*cos(x(4)) - Tau_y_des;
        L*x(1)*sin(x(3)) - L*x(2)*sin(x(4)) - Tau_z_des;
    ].^2);

    options = optimoptions('fmincon', 'Display', 'none', 'Algorithm', 'sqp');
    [x, ~, exitflag] = fmincon(objective, x0, [], [], [], [], lb, ub, [], options);

    % Always return the result, even if it's approximate
    T1 = x(1);
    T2 = x(2);
    delta1 = x(3);
    delta2 = x(4);
end
