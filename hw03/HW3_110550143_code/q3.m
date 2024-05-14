clc;

P0 = [0, 0];    % (0, 0)
P1 = [1, 0.3];  % (1, 0.3)
P2 = [2, 1.7];  % (2, 1.7)
P3 = [3, 1.5];  % (3, 1.5)

t = linspace(0, 1, 100);  % Adjust the number of points as needed

% Compute the cubic Bezier curve
Bx = (1-t).^3 .* P0(1) + 3*(1-t).^2 .* t .* P1(1) + 3*(1-t) .* t.^2 .* P2(1) + t.^3 .* P3(1);
By = (1-t).^3 .* P0(2) + 3*(1-t).^2 .* t .* P1(2) + 3*(1-t) .* t.^2 .* P2(2) + t.^3 .* P3(2);

% Plot the Bezier curve
plot(Bx, By, 'b-', 'LineWidth', 2);
hold on;

% Plot the zigzag line
points = [0, 0; 1, 0.3; 2, 1.7; 3, 1.5];
plot(points(:, 1), points(:, 2), 'r--o', 'LineWidth', 1.5);

% Add labels and legend
xlabel('x');
ylabel('y');
title('Cubic Bezier Curve and Zigzag Line');
legend('Cubic Bezier Curve', 'Zigzag Line', 'Location', 'Best');

% Set axis equal and grid
axis equal;
grid on;

% Show plot
hold off;

% find the Bezier curve passes through all of the original four points


