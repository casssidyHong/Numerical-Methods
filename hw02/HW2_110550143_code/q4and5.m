clc;

% Given system matrix A and right-hand side vector b
A = [7, -3, 4;
    -3, 2, 6;
    2, 5, 3];
b = [6; 2; -5];

% Initial guess vector
x0 = [0; 0; 0];

% disp('Previous A:');
% disp(A)
% Check diagonal dominance
for i = 1:size(A, 1)
    if abs(A(i, i)) <= sum(abs(A(i, :))) - abs(A(i, i))
        [~, idx] = max(abs(A(i, :)));
        temp_row = A(i, :);
        A(i, :) = A(idx, :);
        A(idx, :) = temp_row;
        temp_b = b(i);
        b(i) = b(idx);
        b(idx) = temp_b;
    end
end
% disp('Diagonal Dominance A: ')
% disp(A)

fprintf('4. Jacobi method\n');
[x4, iter4] = jacobi_iteration(A, b, x0, 1000);
% Display the solution vector x
fprintf('  (a) Solution vector x:\n');
fprintf('      %.4f\n', x4);
fprintf('  (b) Number of iterations: %d\n', iter4);

fprintf('\n5. Gauss-Seidel method\n');
[x5, iter5] = gauss_seidel_method(A, b, x0, 1000);
% Display the solution vector x
fprintf('  (a) Solution vector x:\n');
fprintf('      %.4f\n', x5);
fprintf('  (b) Number of iterations: %d\n', iter5);
fewer = iter4-iter5;
fprintf('      -> %d fewer iterations\n', fewer);

function [x, iter] = jacobi_iteration(A, b, x0, max_iter)
    % Initialize variables
    x = x0;
    x_prev = x0;
    errors = zeros(max_iter, 1);

    % Jacobi iteration
    for iter = 1:max_iter
        for i = 1:length(b)
            sum_term = 0;
            for j = 1:length(b)
                if j ~= i
                    sum_term = sum_term + A(i, j) * x_prev(j);
                end
            end
            x(i) = (b(i) - sum_term) / A(i, i);
        end

        % Calculate the error
        errors(iter) = norm(x - x_prev, inf);

        % Check for convergence
        if errors(iter) < 1e-5
            break;
        end

        % Update x_prev for the next iteration
        x_prev = x;
    end
end

function [x, iter] = gauss_seidel_method(A, b, x0, max_iter)
    % Initialize variables
    x = x0;
    errors = zeros(max_iter, 1);

    % Gauss-Seidel iteration
    for iter = 1:max_iter
        x_prev = x; % Store the previous iteration values

        for i = 1:length(b)
            sum_term = 0;
            for j = 1:length(b)
                if j ~= i
                    sum_term = sum_term + A(i, j) * x(j);
                end
            end
            x(i) = (b(i) - sum_term) / A(i, i);
        end

        % Calculate the error
        errors(iter) = norm(x - x_prev, inf);

        % Check for convergence
        if errors(iter) < 1e-5
            break;
        end
    end
end

