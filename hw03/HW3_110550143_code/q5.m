clc;

% Given data
x = [0.40, 1.2, 3.4, 4.1, 5.7, 7.2, 9.3];
y = [0.70, 2.1, 4.0, 4.9, 6.3, 8.1, 8.9];
z = [0.031, 0.933, 3.058, 3.349, 4.870, 5.757, 8.921];

% Calculate the necessary sums
n = length(x);
sum_x = sum(x);
sum_y = sum(y);
sum_z = sum(z);
sum_x2 = sum(x.^2);
sum_y2 = sum(y.^2);
sum_xy = sum(x .* y);
sum_xz = sum(x .* z);
sum_yz = sum(y .* z);

% Formulate the normal equations
A = [sum_x2, sum_xy, sum_x;
    sum_xy, sum_y2, sum_y;
    sum_x, sum_y, n];
b = [sum_xz; sum_yz; sum_z];

% Solve the normal equations
coefficients = A \ b;

% Extract the coefficients
a = coefficients(1);
b = coefficients(2);
c = coefficients(3);

fprintf('(b) z = %.5fx + %.5fy + %.5f.\n', a, b, c);
fprintf('    -> (a, b, c) = (%.5f, %.5f, %.5f)\n', a, b, c);

predicted_z = a * x + b * y + c;
squares_of_deviations = (predicted_z - z).^2;
sum_of_squares_of_deviations = sum(squares_of_deviations);

% Display the result
fprintf('(c) Sum of squares of deviations: %.4f\n', sum_of_squares_of_deviations);
