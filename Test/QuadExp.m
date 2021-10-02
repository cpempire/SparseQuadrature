% test quadrature rule for function Exp(x/j^\alpha)
clear
close all 
d = 1e4;%length(Data.Lambda);
Data.dstep = 1;
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'gauss-patterson', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','one', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));
            
Data.gridType = spget(options,'GridType','gauss-hermite');

range = [];
f = @test_fun_alpha1;
%% tGKP
% z = spvals(f, d, range, options, Data);
% visualization(z)                         
% pause(2)
% 
% options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
% z = spvals(f, d, range, options, Data);
% visualization(z)  
% 
% tGKP.maxLevel = z.maxLevel;
% tGKP.Mean = z.Mean;
% tGKP.Emean = z.Emean;
% tGKP.Emeank = z.Emeank;
% tGKP.nindex = z.nindex;
% tGKP.allpoints = z.allpoints;
% tGKP.oldpoints = z.oldpoints;

%% GK
clear z
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'kronrod-patterson-normal', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','one', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));

Data.gridType = spget(options,'GridType','gauss-hermite');

z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

GK.maxLevel = z.maxLevel;
GK.Mean = z.Mean;
GK.Emean = z.Emean;
GK.Emeank = z.Emeank;
GK.nindex = z.nindex;
GK.allpoints = z.allpoints;
GK.oldpoints = z.oldpoints;

%% GH2
clear z
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'gauss-hermite', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','double', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));

Data.gridType = spget(options,'GridType','gauss-hermite');            
z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

GH2.maxLevel = z.maxLevel;
GH2.Mean = z.Mean;
GH2.Emean = z.Emean;
GH2.Emeank = z.Emeank;
GH2.nindex = z.nindex;
GH2.allpoints = z.allpoints;
GH2.oldpoints = z.oldpoints;

%% GH1 
clear z
options = spset('RelTol', 1e-12, 'AbsTol', 1e-12, ...
                'GridType', 'gauss-hermite', ... %kronrod-patterson-normal / gauss-hermite / gauss-patterson
                'DimensionAdaptive', 'on', ...
                'DimadaptDegree', 1, ...
                'ProblemType','integration',...
                'GrowthLevel','one', ... %double / one
                'FunctionArgType', 'vector', ...
                'KeepGrid','off',...
                'KeepWeight', 'off',...
                'KeepFunctionValues','on',...
                'MinPoints', 1, ...
                'MaxPoints', min(1e3,Data.dstep*3));

Data.gridType = spget(options,'GridType','gauss-hermite');            
z = spvals(f, d, range, options, Data);
visualization(z)                         
pause(2)

options = spset(options, 'MaxPoints', 1e5, 'PrevResults',z);
z = spvals(f, d, range, options, Data);
visualization(z)  

GH1.maxLevel = z.maxLevel;
GH1.Mean = z.Mean;
GH1.Emean = z.Emean;
GH1.Emeank = z.Emeank;
GH1.nindex = z.nindex;
GH1.allpoints = z.allpoints;
GH1.oldpoints = z.oldpoints;

%%
save QuadExpAlpha1 tGKP GK GH1 GH2

%%
load QuadExpAlpha1
test_value = exp(sum((1:10000).^(-2))/2);

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
y = 1./x.^(.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-1/2}')
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
y = 1./(1:length(GK.oldpoints)).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-1/2}')
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

x = 1:1e5;
y = 1./(1:1e5).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--')

legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-1/2}')
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
y = 1./(1:1e4).^(.5);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x, y,'k--')
legend('\fontsize{16}GH1','\fontsize{16}GH2','\fontsize{16}tGKP',...
       '\fontsize{16}GK','\fontsize{16}N^{-1/2}')
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