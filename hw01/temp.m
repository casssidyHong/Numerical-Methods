clc;

% Define the function
f = @(x) x.^2 + exp(x) - 5;

% Define Muller's method function
function xr = muller_method(f, x0, tol)
    xr = 0;
    x1 = x0 + 1; 
    x2 = x0 - 1;

    while abs(f(xr)) > tol 
        h1 = x1 - x0;
        h2 = x0 - x2;
        r = h2 / h1;

        f_0 = f(x0);
        f_1 = f(x1);
        f_2 = f(x2);

        c = f_0;
        a = (r*f_1 - f_0*(1+r) + f_2) / (r * h1^2 * (1 + r));
        b = (f_1 - f_0 - a * h1^2) / h1;

        add = x0 - (2 * c / (b + sqrt(b^2 - 4*a*c)));
        sub = x0 - (2 * c / (b - sqrt(b^2 - 4*a*c)));

        if abs(add - x0) < abs(sub - x0)
            xr = add;
        else 
            xr = sub;
        end

        if abs(xr - x0) < tol
            break;
        end

        x2 = x1;
        x1 = x0;
        x0 = xr;
    end
end

% Set tolerance
tol = 1e-10;

% Find roots near x=1 and x=-2 using Muller's method
xr1 = muller_method(f, 1, tol);
xr2 = muller_method(f, -2, tol);

% Display the roots
disp(['Root near x=1: ', num2str(xr1)]);
disp(['Root near x=-2: ', num2str(xr2)]);
