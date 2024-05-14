clc;

% Given matrix A
A = [2, -1, 3, 2;
     2, 2, 0, 4;
     1, 1, -2, 2;
     1, 3, 4, -1];

A = A / 2;

n = size(A, 1); 
L = eye(n); 
U = A; 

for k = 1:n-1
    for i = k+1:n
        factor =  U(i, k) / U(k, k);
        U(i, :) = U(i, :) - factor * U(k, :);
        L(i, k) = factor; % Store the multiplier in L
    end
    fprintf('STEP(%d)\n', k);
    fprintf('L:\n');
    disp(L);
    fprintf('U:\n', k);
    disp(U);
end

L = 2 * L;

disp('Matrix L:');
disp(L);
disp('Matrix U:');
disp(U);
