function w = barycentricweight(x)

n = length(x);
w = ones(1,n);
if n == 1
    return
end

w(1) = prod(1./(x(1)-x(2:end)));
w(end) = prod(1./(x(end)-x(1:end-1)));
for m = 2:n-1
    w(m) = prod(1./(x(m)-x(1:m-1)))*prod(1./(x(m)-x(m+1:end)));
end

w = w/max(abs(w));