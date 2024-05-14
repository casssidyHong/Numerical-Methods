clc;

function [x_sol, y_sol] = newtons_method_system(x, y, tol, max_iter)

    for iter = 1:max_iter
        % Calculate functions
        f = y - cos(x)^2;
        g = x^2 + y^2 - x - 2;

        % Calculate Jacobian matrix
        J = [-2*sin(x)*cos(x), 1;
             2*x - 1, 2*y];

        % Update solution
        delta = -J \ [f; g];
        x = x + delta(1);
        y = y + delta(2);

        % Check for convergence
        if abs(delta(1)) < tol && abs(delta(2)) < tol
            x_sol = x;
            y_sol = y;
            % disp(['Converged in ', num2str(iter), ' iterations']);
            return;
        end
    end

    % disp('Max iterations reached without convergence');
    x_sol = NaN;
    y_sol = NaN;
end

% Set tolerance and maximum iterations
tol = 1e-6;
max_iter = 100;

[x_sol, y_sol] = newtons_method_system(1, 1, tol, max_iter);
disp(['Solution 1 (x, y): (', num2str(x_sol), ', ', num2str(y_sol), ')']);

[x_sol, y_sol] = newtons_method_system(-1, -1, tol, max_iter);
disp(['Solution 2 (x, y): (', num2str(x_sol), ', ', num2str(y_sol), ')']);
