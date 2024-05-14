clc;

A = [2, -2; -2, 2];
b = [0, 0];

fprintf('PART(a)\n');
x0 = [1, 1];
[x1, iter1] = jacobi_iteration(A, b, x0, 1000);
conver(1, x0, x1, iter1);
x0 = [1, -1];
[x1, iter1] = jacobi_iteration(A, b, x0, 1000);
[x2, iter2] = jacobi_iteration(A, b, x0, 999);
alter(2, x0, x1, x2, iter1, iter2);
x0 = [-1, 1];
[x1, iter1] = jacobi_iteration(A, b, x0, 1000);
[x2, iter2] = jacobi_iteration(A, b, x0, 999);
alter(3, x0, x1, x2, iter1, iter2);
x0 = [2, 5];
[x1, iter1] = jacobi_iteration(A, b, x0, 1000);
[x2, iter2] = jacobi_iteration(A, b, x0, 999);
alter(4, x0, x1, x2, iter1, iter2);
x0 = [5, 2];
[x1, iter1] = jacobi_iteration(A, b, x0, 1000);
[x2, iter2] = jacobi_iteration(A, b, x0, 999);
alter(5, x0, x1, x2, iter1, iter2);

fprintf('\nPART(b)\n');
x0 = [1, 1];
[x1, iter1] = gauss_seidel_method(A, b, x0);
conver(1, x0, x1, iter1);
x0 = [1, -1];
[x2, iter2] = gauss_seidel_method(A, b, x0);
conver(3, x0, x2, iter2);
x0 = [-1, 1];
[x3, iter3] = gauss_seidel_method(A, b, x0);
conver(3, x0, x3, iter3);
x0 = [2, 5];
[x4, iter4] = gauss_seidel_method(A, b, x0);
conver(4, x0, x4, iter4);
x0 = [5, 2];
[x5, iter5] = gauss_seidel_method(A, b, x0);
conver(5, x0, x5, iter5);

A = [2, -1.99; -1.99, 2];
b = [0, 0];

fprintf('\nPART(c-a)\n');
x0 = [1, 1];
[x1, iter1] = jacobi_iteration(A, b, x0, 10000);
cconver(1, x0, x1, iter1);
x0 = [1, -1];
[x1, iter1] = jacobi_iteration(A, b, x0, 10000);
cconver(1, x0, x1, iter1);
x0 = [-1, 1];
[x1, iter1] = jacobi_iteration(A, b, x0, 10000);
cconver(1, x0, x1, iter1);
x0 = [2, 5];
[x1, iter1] = jacobi_iteration(A, b, x0, 10000);
cconver(1, x0, x1, iter1);
x0 = [5, 2];
[x1, iter1] = jacobi_iteration(A, b, x0, 10000);
cconver(1, x0, x1, iter1);

fprintf('\nPART(c-b)\n');
x0 = [1, 1];
[x1, iter1] = gauss_seidel_method(A, b, x0);
cconver(1, x0, x1, iter1);
x0 = [1, -1];
[x1, iter1] = gauss_seidel_method(A, b, x0);
cconver(1, x0, x1, iter1);
x0 = [-1, 1];
[x1, iter1] = gauss_seidel_method(A, b, x0);
cconver(1, x0, x1, iter1);
x0 = [2, 5];
[x1, iter1] = gauss_seidel_method(A, b, x0);
cconver(1, x0, x1, iter1);
x0 = [5, 2];
[x1, iter1] = gauss_seidel_method(A, b, x0);
cconver(1, x0, x1, iter1);

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

function [x, iter] = gauss_seidel_method(A, b, x0)
    x = x0;
    error = inf;
    tolerance = 1e-5;
    iter = 0;

    while error > tolerance 
        x_prev = x; 
        for i = 1:length(b)
            sum_term = 0;
            for j = 1:length(b)
                if j < i
                    sum_term = sum_term + A(i, j) * x(j);
                elseif j > i
                    sum_term = sum_term + A(i, j) * x_prev(j);
                end
            end
            x(i) = (b(i) - sum_term) / A(i, i);
        end

        error = norm(x - x_prev, inf);
        iter = iter + 1;
    end
    % disp(A);
end

function conver(n, x0, x, iter)
    fprintf('(%d) For initial guess x0 = [%d, %d]:\n', n, x0);
    fprintf('    Converges to: [%d, %d] (num(iter)=%d)\n', x, iter);
end

function cconver(n, x0, x, iter)
    fprintf('(%d) For initial guess x0 = [%d, %d]:\n', n, x0);
    fprintf('    Converges to: [%.5f, %.5f] (num(iter)=%d)\n', x, iter);
end

function alter(n, x0, x1, x2, iter1, iter2)
    fprintf('(%d) For initial guess x0 = [%d, %d]:\n', n, x0);
    fprintf('    Alternates between: [%d, %d], [%d, %d] (num(iter)=%d, %d)\n', x1, x2, iter1, iter2);
end
