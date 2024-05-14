clc;

% Define the coefficients of the equations
A = [0.1, 51.7; 5.1, -7.3];
B = [104; 16];

% Plot the lines
x = linspace(0, 20, 100);
y1 = (104 - 0.1*x) / 51.7;
y2 = (5.1*x - 16) / 7.3;

plot(x, y1, 'r', 'LineWidth', 2);
hold on;
plot(x, y2, 'b', 'LineWidth', 2);
xlabel('x');
ylabel('y');
title('Graph of the system of equations');
legend('0.1x + 51.7y = 104', '5.1x - 7.3y = 16', 'Location', 'Best');
grid on;

% Define the coefficients of the equations
A = [0.1, 51.7, 104; 5.1, -7.3, 16];

% Call the function to perform Gaussian elimination without row interchanges
% A1 = gaussian_elimination_no_pivot(A);
% x1 = find_solution(A1);
% A2 = gaussian_elimination_with_pivoting(A);
% x2 = find_solution(A2);
% A3 = gaussian_elimination_with_scaled_pivoting(A);
% x3 = find_solution(A3);

% Display the solution
% fprintf('(a) Solution without row interchanges:\n\n');
% disp(A1);
% disp(['    x = ', num2str(x1(1), '%.3f')]);
% disp(['    y = ', num2str(x1(2), '%.3f')]);
% fprintf('\n(b) Solution with partial pivoting:\n\n');
% disp(A2);
% disp(['    x = ', num2str(x2(1), '%.3f')]);
% disp(['    y = ', num2str(x2(2), '%.3f')]);
% fprintf('\n(c) Solution with scaled partial pivoting:\n\n');
% disp(A3);
% disp(['    x = ', num2str(x3(1), '%.3f')]);
% disp(['    y = ', num2str(x3(2), '%.3f')]);

function A = gaussian_elimination_no_pivot(A)
    % Perform Gaussian elimination without row interchanges
    for k = 1:size(A, 1)-1
        for i = k+1:size(A, 1)
            factor = A(i, k) / A(k, k);
            A(i, :) = A(i, :) - factor * A(k, :);
        end
    end
    % disp(A);
end

function A = gaussian_elimination_with_pivoting(A)
    % Perform Gaussian elimination with partial pivoting
    for k = 1:size(A, 1)-1
        [~, pivot_row] = max(abs(A(k:end, k)));
        pivot_row = pivot_row + k - 1;
        if pivot_row ~= k
            A([k, pivot_row], :) = A([pivot_row, k], :);
        end
        
        for i = k+1:size(A, 1)
            factor = A(i, k) / A(k, k);
            A(i, :) = A(i, :) - factor * A(k, :);
        end
    end
    % disp(A);
end

function A = gaussian_elimination_with_scaled_pivoting(A)
    % Perform Gaussian elimination with scaled partial pivoting
    n = size(A, 1);
    scaling_factor = max(abs(A), [], 2); % Calculate scaling factors for each row
    for k = 1:n-1
        [~, pivot_row] = max(abs(A(k:end, k))./scaling_factor(k:end));
        pivot_row = pivot_row + k - 1;
        if pivot_row ~= k
            A([k, pivot_row], :) = A([pivot_row, k], :);
            scaling_factor([k, pivot_row]) = scaling_factor([pivot_row, k]);
        end
        for i = k+1:n
            factor = A(i, k) / A(k, k);
            A(i, :) = A(i, :) - factor * A(k, :);
        end
    end
end

function x = find_solution(A)
    % 進行回代以找到解
    x = zeros(size(A, 1), 1);
    for i = size(A, 1):-1:1
        sum_known = round(A(i, 1:end-1) * x, 3);
        
        intermediate_result = round(A(i, end) - sum_known, 3);
        
        x(i) = round(intermediate_result / A(i, i), 3); % 將每個中間結果四捨五入到三個有效數字
    end
end

