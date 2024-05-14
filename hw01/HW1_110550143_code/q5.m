clc;

f = @(x) exp(x) - 2*x.^2;
g1 = @(x) (exp(x)/2).^(1/2);
g2 = @(x) -(exp(x)/2).^(1/2);

function xr = converge(f, g, xr)
    tol = 1e-10;
    while abs(f(xr)) > tol 
        if f(xr) == 0
            break;
        end
        xr = g(xr);
    end
end

x1 = converge(f, g1, 1);
x_ = converge(f, g1, -1);
x0 = converge(f, g1, 0);
disp(sprintf('(a) Root converge (+) when x=(1, -1, 0): (%.5f, %.5f, %.5f)', x1, x_, x0));
x1 = converge(f, g2, 1);
x_ = converge(f, g2, -1);
x0 = converge(f, g2, 0);
disp(sprintf('    Root converge (-) when x=(1, -1, 0): (%.5f, %.5f, %.5f)', x1, x_, x0));
xp = converge(f, g1, 2.5);
xn = converge(f, g2, 2.5);
disp(sprintf('(b) Root converge when x0=2.5(+, -): (%.5f, %.5f)', xp, xn));
xp = converge(f, g1, 2.7);
xn = converge(f, g2, 2.7);
disp(sprintf('    Root converge when x0=2.7(+, -): (%.5f, %.5f)', xp, xn));

g3 = @(x) log(2*x.^2);
xn = converge(f, g3, 2.6);
x1 = converge(f, g3, 1);
x_ = converge(f, g3, -1);
disp(sprintf('(c) Root converge when x0=(2.6, 1, -1) (g(x)=ln(2x^2)): (%.5f, %.5f, %.5f)', xn, x1, x_));


