%% plot 
load QuadExpAlpha3
test_value = exp(sum((1:10000).^(-6))/2);

figure
x = double(GH1.oldpoints);
n = length(x);
y = test_value - abs(GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'cx-') % remove  for QuadExp2

hold on 
x = double(GH2.oldpoints);
n = length(x);
y = test_value - abs(GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = double(tGKP.oldpoints);
n = length(x);
y = test_value - abs(tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = double(GK.oldpoints);
n = length(x);
y = test_value - abs(GK.Mean{1}(2:end) - GK.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.-','MarkerSize',10)

x = double(GK.oldpoints);
n = length(x);
y = 1./x.^(2.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-5/2}')
xlabel('$|G_{\Lambda}|$', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpEmean1full.eps','epsc')
%%
figure
x = 1:length(GH1.oldpoints);
y = test_value - abs(GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'cx-')

hold on 
x = 1:length(GH2.oldpoints);
y = test_value - abs(GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = 1:length(tGKP.oldpoints);
y = test_value - abs(tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = 1:length(GK.oldpoints);
y = test_value - abs(GK.Mean{1}(2:end) - GK.Emean{1}(2:end));
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.-','MarkerSize',10)

x = 1:length(GK.oldpoints);
y = 1./(1:length(GK.oldpoints)).^(3);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-3}')
xlabel('$|\Lambda|$', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpEmeanIndex1full.eps','epsc')
%% 
figure
x = GH1.allpoints;
y = abs(GH1.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end),y(1:end),'cx-')

hold on
x = GH2.allpoints;
y = abs(GH2.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = tGKP.allpoints;
y = abs(tGKP.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.-','MarkerSize',10)

load MCAlpha3
loglog(2.^(0:16),sum(f_error)/100,'gs-')

x = 1:1e5;
y = 1./(1:1e5).^(2.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--')

x = 1:1e5;
y = 1./(1:1e5).^(0.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k-.')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}MC','\fontsize{16}N^{-5/2}','\fontsize{16}N^{-1/2}')
xlabel('$|G_{\bar{\Lambda}}|$', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\bar{\Lambda}}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpMean1full.eps','epsc')
%%
figure
x = GH1.nindex;
y = abs(GH1.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'cx-')

hold on
x = GH2.nindex;
y = abs(GH2.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = tGKP.nindex;
y = abs(tGKP.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = GK.nindex;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.-','MarkerSize',10)

x = 1:1e4;
y = 1./(1:1e4).^(2.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--')
legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-5/2}')
xlabel('$|\bar{\Lambda}|$', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\bar{\Lambda}}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpMeanIndex1full.eps','epsc')
%%

%%
% figure
% x = 1:length(GH1.Emeank);
% y = GH1.Emeank;
% 
% loglog(x, y,'c--')
% hold on 
% loglog(x,1./x,'k-')
% loglog(x,1./x.^2,'k--')
% legend('|\Delta_\nu(f)|','N^{-1}','N^{-2}')
% xlabel('\fontsize{16} # indices')
% ylabel('$|\triangle_{\nu}(f)|$','FontSize',16,'Interpreter','latex')
% set(gca,'FontSize',16)
% saveas(gca,'QuadExpGH1Delta.eps','epsc')
% saveas(gca,'QuadExpGH1Delta.fig')
%%
figure
bar(GH1.maxLevel)
xlabel('dimension (GH1)')
ylabel('level')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpGH1Level1full.eps','epsc')

figure
bar(GH2.maxLevel)
xlabel('dimension (GH2)')
ylabel('level')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpGH2Level1full.eps','epsc')

figure
bar(tGKP.maxLevel)
xlabel('dimension (tGKP)')
ylabel('level')
set(gca,'FontSize',16)
saveas(gcf,'QuadExptGKPLevel1full.eps','epsc')

figure
bar(GK.maxLevel)
xlabel('dimension (GK)')
ylabel('level')
set(gca,'FontSize',16)
saveas(gcf,'QuadExpGKLevel1full.eps','epsc')