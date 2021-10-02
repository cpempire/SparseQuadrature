% QuadExp
load QuadExp2

figure
x = double(GH1.oldpoints);
n = length(x);
y = GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'cx-') % remove  for QuadExp2

hold on 
x = double(GH2.oldpoints);
n = length(x);
y = GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = double(tGKP.oldpoints);
n = length(x);
y = tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = double(GK.oldpoints);
n = length(x);
y = GK.Mean{1}(2:end) - GK.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.-','MarkerSize',10)

x = double(GK.oldpoints);
n = length(x);
y = 1./x.^(1.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--')
y = 1./double(GK.oldpoints).^2;
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-3/2}','\fontsize{16}N^{-2}')
xlabel('\fontsize{16} # points')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpMeanErrorPoints2.eps','epsc')
%%
figure
x = 1:length(GH1.oldpoints);
y = GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'cx-')

hold on 
x = 1:length(GH2.oldpoints);
y = GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = 1:length(tGKP.oldpoints);
y = tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = 1:length(GK.oldpoints);
y = GK.Mean{1}(2:end) - GK.Emean{1}(2:end);
y = abs(GK.Mean{1}(end) - y);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.-','MarkerSize',10)

x = 1:length(GK.oldpoints);
y = 1./(1:length(GK.oldpoints)).^(1.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--')
y = 1./(1:length(GK.oldpoints)).^(2);
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-3/2}','\fontsize{16}N^{-2}')
xlabel('\fontsize{16} # indices')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpMeanErrorIndex2.eps','epsc')