function f = test_fun_alpha3(x,Data)

if strcmpi(Data.gridType,'gauss-patterson')
    x = icdf('normal',x,0,1);
end

 f = exp(sum(x./(1:length(x)).^3));%x.^10;%(cdf('normal',x,0,1))^10;
% f = exp(x/10);