clc;

% Define the given data points
x = [-0.2, 0.3, 0.7, -0.3, 0.1];
fx = [1.23, 2.34, -1.05, 6.51, -0.06];

% Display the divided-difference table
a = difference(x, fx);
fprintf("(a) Divided-difference table:\n\n");
disp(a);

% Interpolate the value at x = 0.4 using the divided-difference table
b = interpolation(0.4, a, x);
fprintf("(b) Interpolated value at x = 0.4: %.4f\n", b);

% Get the three points closest to x = 0.4
c_1 = best_set(x, 0.4);

% Display the three closest points
fprintf("(c) Three points: %.2f %.2f %.2f\n", c_1);

% closest_indices = find(ismember(x, c_1));
closest_indices = [5, 2, 3]; %choose by my self
fx_closest = fx(closest_indices);
c_2 = difference(c_1, fx_closest);
fprintf("   (1) Divided-difference table:\n");
disp(c_2);
c_3 = interpolation(0.4, c_2, c_1);
fprintf("   (2) Interpolated value at x = 0.4: %.5f\n", c_3);


function difference_table = difference(x, fx)
    % Calculate the divided-difference table
    n = length(x);
    table = zeros(n, n); % Initialize the table with zeros
    
    table(:, 1) = fx';
    % Compute divided differences recursively
    for j = 2:n
        for i = 1:n-j+1
            table(i, j) = (table(i+1, j-1) - table(i, j-1)) / (x(i+j-1) - x(i));
        end
    end
    
    difference_table = table;
end

% Use Newton's interpolation formula
function interp_value = interpolation(x_interp, table, x)
    n = length(x);
    interp_value = table(1, 1); % Initialize with f(x0)
    for j = 2:n
        term = table(1, j);
        for i = 1:j-1
            term = term * (x_interp - x(i));
        end
        interp_value = interp_value + term;
    end
end

function best = best_set(x, x_interp)
    % Calculate absolute differences from the interpolation point
    abs_diff = abs(x - x_interp);
    
    % Sort the absolute differences and get the indices
    [~, indices] = sort(abs_diff);
    
    % Extract the three closest points
    closest_points_indices = indices(1:3);
    closest_points = x(closest_points_indices);
    
    % Sort the three closest points in ascending order
    best = sort(closest_points);
end

