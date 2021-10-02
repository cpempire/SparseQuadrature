close all

%% plot all points and indices
figure

load MCAlpha1
loglog(2.^(0:16),sum(f_error)/100,'gx-')
hold on 
load ../ExpAlpha2/MCAlpha2
loglog(2.^(0:16),sum(f_error)/100,'c>-')
load ../ExpAlpha3/MCAlpha3
loglog(2.^(0:16),sum(f_error)/100,'m<-')

load QuadExpAlpha1Priori
test_value = exp(sum((1:10000).^(-2))/2);

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'rs-')
hold on 

load QuadExpAlpha2Priori
test_value = exp(sum((1:10000).^(-4))/2);

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

load QuadExpAlpha3Priori
test_value = exp(sum((1:10000).^(-6))/2);

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

load QuadExpAlpha1
test_value = exp(sum((1:10000).^(-2))/2);

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'rs--')
hold on 


load QuadExpAlpha2
test_value = exp(sum((1:10000).^(-4))/2);

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd--')
load QuadExpAlpha3
test_value = exp(sum((1:10000).^(-6))/2);

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*--')

x = 1:1e5;
y = 10./(1:1e5).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k-.','LineWidth',2)

x = 1:1e5;
y = 10./(1:1e5).^(1.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--','LineWidth',2)

x = 1:1e5;
y = 10./(1:1e5).^(2.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k:','LineWidth',2)

axis([1,1e5,1e-12,1e1])
lgd = legend('\alpha = 1 \fontsize{16}MC', '\alpha = 2 \fontsize{16}MC', '\alpha = 3 \fontsize{16}MC', ...
       '\alpha = 1 priori \fontsize{16}GK', '\alpha = 2 priori \fontsize{16}GK', '\alpha = 3 priori \fontsize{16}GK',...
       '\alpha = 1 posteriori \fontsize{16}GK', '\alpha = 2 posteriori \fontsize{16}GK', '\alpha = 3 posteriori \fontsize{16}GK',...
       '\fontsize{16}N^{-1/2}','\fontsize{16}N^{-3/2}','\fontsize{16}N^{-5/2}','Location','SouthWest')
set(lgd,'color','none')   
   
xlabel('# points', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\bar{\Lambda}}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'AllPointsPrioriPosteriori.eps','epsc')
%%
figure

% load MCAlpha1
% loglog(2.^(0:16),sum(f_error)/100,'gx-')
% hold on 
% load MCAlpha2
% loglog(2.^(0:16),sum(f_error)/100,'c>-')
% load MCAlpha3
% loglog(2.^(0:16),sum(f_error)/100,'m<-')

load QuadExpAlpha1Priori
test_value = exp(sum((1:10000).^(-2))/2);

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'rs-')
hold on 

load QuadExpAlpha2Priori
test_value = exp(sum((1:10000).^(-4))/2);

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

load QuadExpAlpha3Priori
test_value = exp(sum((1:10000).^(-6))/2);

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

load QuadExpAlpha1
test_value = exp(sum((1:10000).^(-2))/2);

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'rs--')
hold on 


load QuadExpAlpha2
test_value = exp(sum((1:10000).^(-4))/2);

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd--')
load QuadExpAlpha3
test_value = exp(sum((1:10000).^(-6))/2);

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*--')

x = 1:1e4;
y = 1./(1:1e4).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k-.','LineWidth',2)

x = 1:1e4;
y = 1./(1:1e4).^(1.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--','LineWidth',2)

x = 1:1e4;
y = 1./(1:1e4).^(2.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k:','LineWidth',2)

axis([1,1e5,1e-12,1e1])
lgd = legend('\alpha = 1 priori \fontsize{16}GK', '\alpha = 2 priori \fontsize{16}GK', '\alpha = 3 priori \fontsize{16}GK',...
       '\alpha = 1 posteriori \fontsize{16}GK', '\alpha = 2 posteriori \fontsize{16}GK', '\alpha = 3 posteriori \fontsize{16}GK',...
       '\fontsize{16}N^{-1/2}','\fontsize{16}N^{-3/2}','\fontsize{16}N^{-5/2}','Location','SouthWest')
set(lgd,'color','none')   
xlabel('# indices', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\bar{\Lambda}}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'AllIndicesPrioriPosteriori.eps','epsc')