load QuadExp1

figure
x = GH1.allpoints(1:end-1);
y = abs(GH1.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'cx-')

hold on
x = GH2.allpoints(1:end-1);
y = abs(GH2.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'kd-')

x = tGKP.allpoints(1:end-1);
y = abs(tGKP.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'b*-')

x = GK.allpoints(1:end-1);
y = abs(GK.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'r.-','MarkerSize',10)

x = 1:1e6;
y = 1./(1:1e6).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-1/2}')
xlabel('\fontsize{16} # points')
ylabel('$|I(f) - \mathcal{Q}_{\bar{\Lambda}}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpMean1.eps','epsc')
%%
figure
x = GH1.nindex(1:end-1);
y = abs(GH1.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'cx-')

hold on
x = GH2.nindex(1:end-1);
y = abs(GH2.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'kd-')

x = tGKP.nindex(1:end-1);
y = abs(tGKP.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'b*-')

x = GK.nindex(1:end-1);
y = abs(GK.Mean{1}(1:end-1) - GK.Mean{1}(end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end-1),y(1:end-1),'r.-','MarkerSize',10)

x = 1:1e5;
y = 1./(1:1e5).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--')
legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-1/2}')
xlabel('\fontsize{16} # indices')
ylabel('$|I(f) - \mathcal{Q}_{\bar{\Lambda}}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpMeanIndex1.eps','epsc')
