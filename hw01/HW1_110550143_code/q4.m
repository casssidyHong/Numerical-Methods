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


clc;
tol = 1e-5;

%(a) 4x3 −3x2 +2x−1=0,rootnearx=0.6.
f1 = @(x) 4*x.^3 - 3*x.^2 + 2*x - 1;
xr = muller_method(f1, 0.6, tol);

% disp(xr);
disp(sprintf('(a) Root near 0.6: %.5f', xr));

%(b) x2 +ex =5,rootsnearx=1,x=−2.
f2 = @(x) x.^2 + exp(x) - 5;
xr = muller_method(f2, 1, tol);
disp(sprintf('(b) Root near   1: %.5f', xr));
xr = muller_method(f2, -2, tol);
disp(sprintf('    Root near  -2: %.5f', xr));