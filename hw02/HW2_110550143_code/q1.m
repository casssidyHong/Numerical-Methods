clc;

function [x, row_interchanges] = gaussian_elimination(A)
    [m, n] = size(A);
    if m ~= n-1
        error('The input matrix must be augmented matrix of dimension (n-1) x n.');
    end
    
    row_interchanges = 0; % Initialize row interchange counter
    
    % Forward Elimination
    for k = 1:m-1
        % Partial pivoting
        [~, pivot_row] = max(abs(A(k:m, k)));
        pivot_row = pivot_row + k - 1;
        if pivot_row ~= k
            A([k, pivot_row], :) = A([pivot_row, k], :);
            row_interchanges = row_interchanges + 1; % Increment row interchange counter
        end
        
        for i = k+1:m
            factor = A(i, k) / A(k, k);
            A(i, :) = A(i, :) - factor * A(k, :);
        end
    end
    
    % Back Substitution
    x = zeros(n-1, 1);
    for i = m:-1:1
        x(i) = (A(i, n) - A(i, 1:n-1)*x) / A(i, i);
    end
end

% 输入增广矩阵
A = [3 1 -4 7; -2 3 1 -5; 2 0 5 10];

% 调用高斯消元法函数
[x, row_interchanges] = gaussian_elimination(A);

% 显示结果
disp('Solution:');
disp(x);
disp(['Row interchanges: ', num2str(row_interchanges)]);
