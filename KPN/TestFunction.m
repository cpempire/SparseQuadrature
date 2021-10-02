function y = TestFunction(x)
n = length(x);
y = 0;
for i = 1:n
    y = y + exp(-x(i)^2/2/i^2);
end