function f = test_exp2(x,Data)

if strcmpi(Data.gridType,'gauss-patterson')
    x = icdf('normal',x,0,1);
end

f = exp(-3*sum((x.^2/(1:length(x)))));%x.^10;%(cdf('normal',x,0,1))^10;
% f = exp(sum(x.^2)/10);