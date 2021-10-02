function visualization(z)


figure 
subplot(2,2,1)
bar(z.maxLevel)
xlabel('dimension')
title('maxLevel')

subplot(2,2,2)
x = 2:z.d;
y = abs(z.Emeank(2:z.d));%/z.Mean{1}(end);
loglog(x,y,'.-')
rate =  polyfit(log(double(x)),log(y),1);
fit = exp(rate(1)*log(double(x))+rate(2));
hold on 
loglog(x, fit,'k.-')                      
x = z.d+1:length(z.Emeank);
y = abs(z.Emeank(z.d+1:end));%/z.Mean{1}(end);
hold on 
loglog(x,y,'b.-')
rate_d =  polyfit(log(double(x)),log(y),1);
fit = exp(rate_d(1)*log(double(x))+rate_d(2));
hold on
loglog(x, fit, 'r.-')
textcontent = ['# indices,  rate = ', num2str([rate(1), rate_d(1)])];
xlabel(textcontent)
title('Indicator')

subplot(2,2,3)
x = z.allpoints(3:end/2);
y = abs(z.Mean{1}(3:end/2)-z.Mean{1}(end));%/z.Mean{1}(end);
loglog(x,y,'.-')
rate =  polyfit(log(double(x)),log(y),1);
fit = exp(rate(1)*log(double(x))+rate(2));
hold on 
loglog(x, fit,'k.-')                            
textcontent = ['# points,  rate = ', num2str(rate(1))];
xlabel(textcontent)
title('Mean Error')


subplot(2,2,4)
x = z.allpoints(3:end);
y = abs(z.Emean{1}(3:end));%/z.Mean{1}(end);
loglog(x,y,'.-')
rate =  polyfit(log(double(x)),log(y),1);
fit = exp(rate(1)*log(double(x))+rate(2));
hold on 
loglog(x, fit,'k.-')              
textcontent = ['# points,  rate = ', num2str(rate(1))];
xlabel(textcontent)
title('Estimator')