clc;

% Define the domain
x = linspace(-pi, pi, 1000);

% True cosine values
cos_true = cos(x);

% Maclaurin series approximation
maclaurin_approx = 1 - x.^2 / 2 + x.^4 / 24;

% Define the function and Chebyshev polynomials properly for array operations
f = @(x) cos(x);
T0 = @(x) 1 + 0*x;  % Ensures T0 is the same size as x
T1 = @(x) x;
T2 = @(x) 2*x.^2 - 1;
T3 = @(x) 4*x.^3 - 3*x;
T4 = @(x) 8*x.^4 - 8*x.^2 + 1;

% Define the weighting function for the Chebyshev polynomials
w = @(x) 1./sqrt(1-x.^2);

% Integration limits
a = -1;
b = 1;

% Coefficients calculation with vector-friendly operations
a0 = 1/pi * integral(@(x) f(x).*T0(x).*w(x), a, b, 'ArrayValued',true);
a1 = 2/pi * integral(@(x) f(x).*T1(x).*w(x), a, b, 'ArrayValued',true);
a2 = 2/pi * integral(@(x) f(x).*T2(x).*w(x), a, b, 'ArrayValued',true);
a3 = 2/pi * integral(@(x) f(x).*T3(x).*w(x), a, b, 'ArrayValued',true);
a4 = 2/pi * integral(@(x) f(x).*T4(x).*w(x), a, b, 'ArrayValued',true);

fprintf('Coefficients of Chebyshev:\n  a0 = %f, a1 = %f, a2 = %f, a3 = %f, a4 = %f\n', a0, a1, a2, a3, a4);

% Evaluate the Chebyshev polynomials at the points in x
T0_eval = T0(x);
T1_eval = T1(x);
T2_eval = T2(x);
T3_eval = T3(x);
T4_eval = T4(x);

% Example coefficients calculated earlier
a0 = 0.765198; a1 = -0.000000; a2 = -0.229807; a3 = 0.000000; a4 = 0.004953;

% Chebyshev series approximation using evaluated polynomials
chebyshev_approx = a0 * T0_eval + a1 * T1_eval + a2 * T2_eval + a3 * T3_eval + a4 * T4_eval;

% Plotting
% figure;
% plot(x, cos_true, 'k-', 'LineWidth', 2);
% hold on;
% plot(x, maclaurin_approx, 'r--', 'LineWidth', 1.5);
% plot(x, chebyshev_approx, 'b-.', 'LineWidth', 1.5);
% legend('True cos(x)', 'Power Approx.', 'Chebyshev Approx.');
% xlabel('x');
% ylabel('cos(x)');
% title('Comparison of Cosine Approximations');
% grid on;

% Error analysis
error_maclaurin = max(abs(cos_true - maclaurin_approx));
error_chebyshev = max(abs(cos_true - chebyshev_approx));
disp(['Max error Power: ', num2str(error_maclaurin)]);
disp(['Max error Chebyshev: ', num2str(error_chebyshev)]);
