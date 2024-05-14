clc;
% Define the period and limits of integration
T = 3;
x0 = -1;
x1 = 2;

% Function handle for f(x)
f = @(x) x.^2 - 1;

% Calculate a0
a0 = 2/T * integral(@(x) f(x), x0, x1);

% Initialize arrays for coefficients
n_max = 10;
a_n = zeros(1, n_max);
b_n = zeros(1, n_max);

% Calculate an and bn
for n = 1:n_max
    a_n(n) = 2/T * integral(@(x) f(x) .* cos(2*pi*n*x/T), x0, x1);
    b_n(n) = 2/T * integral(@(x) f(x) .* sin(2*pi*n*x/T), x0, x1);
end

fprintf('Display a0~a10, b1~b10:\n\n'); 
fprintf('a0  = %8.3f\n', a0); % Adjust the width as needed
for n = 1:n_max
    fprintf('a%-2d = %8.5f, b%-2d = %8.5f\n', n, a_n(n), n, b_n(n));
end


