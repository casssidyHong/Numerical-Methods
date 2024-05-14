clc;

f = inline('(x-2).^3 * (x-4).^2', 'x');

tol = 0.00001;
a = 1;
b = 5;

while abs(f(b)) > tol
    m = (b+a)/2;
    if f(m)==0
        break;
    elseif f(a)*f(m) < 0
        b = m;
    else
        a = m;
    end
end
disp(sprintf('(1) ans of Bisection Method: %d', m));

a = 1;
b = 5;

while abs(f(b)) > tol
    b = b - f(b)*(a-b)/(f(a)-f(b));
end
disp(sprintf('(2) ans of Secant Method: %d', b));

a = 1;
b = 5;
c = b - f(b)*(a-b)/(f(a)-f(b));

while abs(f(c)) > tol
    c = b - f(b)*(a-b)/(f(a)-f(b));
    if f(c)==0
        break;
    elseif f(c)*f(a) < 0
        b = c;
    else
        a = c;
    end
end
disp(sprintf('(3) ans of False Position: %d', c));