clc;

function root = secant(f, interval)
    x_prev = interval(1);
    x_curr = interval(2);
    x_next = x_curr - f(x_curr)*(x_curr - x_prev)/(f(x_curr) - f(x_prev));
    it = 0;

    while abs(x_next - x_curr) > 1e-5 
        x_prev = x_curr;
        x_curr = x_next;
        x_next = x_curr - f(x_curr)*(x_curr - x_prev)/(f(x_curr) - f(x_prev));
        it = it+1;
    end
    root = x_next;
end

f = @(x) (x-2).^3 .* (x-4).^2;
interval1 = [1, 3];
interval2 = [5, 6];

x1 = secant(f, interval1);
x2 = secant(f, interval2);

disp(['Root within interval [1, 3]: ', num2str(x1, '%.4f')]);
disp(['Root within interval [5, 6]: ', num2str(x2, '%.4f')]);
