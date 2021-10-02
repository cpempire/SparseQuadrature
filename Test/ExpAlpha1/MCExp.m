% Monte Carlo method

test_value = exp(sum((1:1e3).^(-2))/2);

% f = inline('exp(sum(x./(1:length(x)).^2))');
f = @(x) exp(sum(x./(1:length(x)).^1));

f_value = zeros(100,2^16);
f_error = zeros(100,17);
for k = 1:100
    for i = 1:2^16
        x = randn(1,1e3);
        f_value(k,i) = f(x);
    end

    for i = 0:16
        f_error(k,i+1) = abs(test_value - sum(f_value(k,1:2^i))/2^i);
    end
    disp([num2str(k),'/','100'])
end

loglog(2.^(0:16),sum(f_error)/100,'.-')
save MCAlpha1 f_error