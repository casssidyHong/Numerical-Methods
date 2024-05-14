% ver;
clc;

% Define x, y, and z values
x_values = [1.3, 2.5, 3.1, 4.7, 5.5];
y_values = [0.2, 0.4, 0.5, 0.7, 0.9];

z_values = [2.521, 3.721, 4.321, 5.921, 6.721;
    2.792, 3.992, 4.592, 6.192, 6.992;
    2.949, 4.149, 4.749, 6.349, 7.149;
    3.314, 4.514, 5.114, 6.714, 7.514;
    3.760, 4.960, 5.560, 7.160, 7.960];

% Point to interpolate
x0 = 2.8;
y0 = 0.54;

% Find the indices of the nearest x and y values
[~, idx_x] = min(abs(x_values - x0));
[~, idx_y] = min(abs(y_values - y0));

% Extract the 2x2 sub-matrix of z values
z11 = z_values(idx_y, idx_x);
z12 = z_values(idx_y, idx_x+1);
z21 = z_values(idx_y+1, idx_x);
z22 = z_values(idx_y+1, idx_x+1);

% Calculate the interpolation coefficients
x1 = x_values(idx_x);
x2 = x_values(idx_x+1);
y1 = y_values(idx_y);
y2 = y_values(idx_y+1);

t = (x0 - x1) / (x2 - x1);
u = (y0 - y1) / (y2 - y1);

% Bilinear interpolation
z_interp = (1 - t) * (1 - u) * z11 + t * (1 - u) * z12 + (1 - t) * u * z21 + t * u * z22;

fprintf('The value of z(2.8, 0.54) is approximately %.5f\n', z_interp);