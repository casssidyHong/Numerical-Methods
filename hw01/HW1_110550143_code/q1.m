clc;

f = @(x) x*sin((x-2)/(x-1));

tol = 1e-5;
result = [];
iter = [];
a_re = [0.94, 0.95, 0.955, 0.96, 0];
b_re = [0.95, 0.955, 0.96, 0.965, 0];
num = 0;

a = a_re(1);
b = b_re(1);
iter_ = 0;

while num < 4
    while abs(f(b)) > tol 
        iter_ = iter_+1;
        m = (b+a)/2;
        if f(m)==0
            b = m;
            break;
        elseif f(a)*f(m) < 0
            b = m;
        else
            a = m;
        end
        if ismember(b, result)
            b = (a + b) / 2;
        end
    end
    num = num+1;
    result(num) = b;
    iter(num) = iter_;
    a = a_re(num+1);
    b = b_re(num+1);
    iter_ = 0;
end
disp(sprintf('Four zeros nearest to x=0.95:  %.5f, %.5f, %.5f, %.5f', result));
disp(sprintf(['Each initial a:                %.3f,     %.3f,   %.3f,   %.3f '] ...
              , a_re(1), a_re(2), a_re(3), a_re(4)));
disp(sprintf(['Each initial b:                %.3f,     %.3f,   %.3f,   %.3f '] ...
              , b_re(1), b_re(2), b_re(3), b_re(4)));
disp(sprintf(['Each iteration:                   %d,        %d,      %d,      %d'] ...
              , iter(1), iter(2), iter(3), iter(4)));
% disp(result)
% disp(a_re)
% disp(b_re)