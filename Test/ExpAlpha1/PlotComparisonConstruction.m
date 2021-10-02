close all

%% compare goal-oriented adaptive construction and a priori construction

figure
load QuadExpAlpha1Priori
test_value = exp(sum((1:10000).^(-2))/2);

x = double(GH1.oldpoints);
n = length(x);
y = test_value - abs(GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'co-') % remove  for QuadExp2

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
loglog(x,y,'r<-')

load QuadExpAlpha1
test_value = exp(sum((1:10000).^(-2))/2);

x = double(GH1.oldpoints);
n = length(x);
y = test_value - abs(GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'co--') % remove  for QuadExp2

hold on 
x = double(GH2.oldpoints);
n = length(x);
y = test_value - abs(GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd--')

x = double(tGKP.oldpoints);
n = length(x);
y = test_value - abs(tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*--')

x = double(GK.oldpoints);
n = length(x);
y = test_value - abs(GK.Mean{1}(2:end) - GK.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r<--')

% load MCAlpha1
% loglog(2.^(0:16),sum(f_error)/100,'gs-.')

x = double(GK.oldpoints);
n = length(x);
y = 1./x.^(.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.','LineWidth',2)

% x = double(GK.oldpoints);
% n = length(x);
% y = 2./x.^(.5);
% x = x(floor(2.^(0:log2(n))));
% y = y(floor(2.^(0:log2(n))));
% loglog(x,y,'k--','LineWidth',2)
% axis([1,1e5,1e-7,1e1])
legend('priori \fontsize{16}GH1','priori \fontsize{16}GH2','priori \fontsize{16}tGKP',...
       'priori \fontsize{16}GK', ...
       'posteriori \fontsize{16}GH1','posteriori \fontsize{16}GH2','posteriori \fontsize{16}tGKP',...
       'posteriori \fontsize{16}GK','\fontsize{16}N^{-1/2}')

xlabel('# points', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'OldPointsPrioriPosterioriAlpha1.eps','epsc')
%% 
figure

load QuadExpAlpha1Priori
test_value = exp(sum((1:10000).^(-2))/2);

x = 1:length(GH1.oldpoints);
n = length(x);
y = test_value - abs(GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'co-') % remove  for QuadExp2

hold on 
x = 1:length(GH2.oldpoints);
n = length(x);
y = test_value - abs(GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-')

x = 1:length(tGKP.oldpoints);
n = length(x);
y = test_value - abs(tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*-')

x = 1:length(GK.oldpoints);
n = length(x);
y = test_value - abs(GK.Mean{1}(2:end) - GK.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r<-')

load QuadExpAlpha1
test_value = exp(sum((1:10000).^(-2))/2);

x = 1:length(GH1.oldpoints);
n = length(x);
y = test_value - abs(GH1.Mean{1}(2:end) - GH1.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'co--') % remove  for QuadExp2

hold on 
x = 1:length(GH2.oldpoints);
n = length(x);
y = test_value - abs(GH2.Mean{1}(2:end) - GH2.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd--')

x = 1:length(tGKP.oldpoints);
n = length(x);
y = test_value - abs(tGKP.Mean{1}(2:end) - tGKP.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b*--')

x = 1:length(GK.oldpoints);
n = length(x);
y = test_value - abs(GK.Mean{1}(2:end) - GK.Emean{1}(2:end));
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r<--')

% load MCAlpha1
% loglog(2.^(0:16),sum(f_error)/100,'gs-.')

x = 1:length(GK.oldpoints);
n = length(x);
y = 1./x.^(.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.','LineWidth',2)

legend('priori \fontsize{16}GH1','priori \fontsize{16}GH2','priori \fontsize{16}tGKP',...
       'priori \fontsize{16}GK', ...
       'posteriori \fontsize{16}GH1','posteriori \fontsize{16}GH2','posteriori \fontsize{16}tGKP',...
       'posteriori \fontsize{16}GK','\fontsize{16}N^{-1/2}')

xlabel('# indices', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'OldIndicesPrioriPosterioriAlpha1.eps','epsc')
%% 
figure
load QuadExpAlpha1
test_value = exp(sum((1:10000).^(-2))/2);

x = GH1.allpoints;
y = abs(GH1.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x(1:end),y(1:end),'co-')

hold on
x = GH2.allpoints;
y = abs(GH2.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'kd-.')

x = tGKP.allpoints;
y = abs(tGKP.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b>--')

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r<:')

load MCAlpha1
loglog(2.^(0:16),sum(f_error)/100,'gs-.')

load QuadExpAlpha1Priori
test_value = exp(sum((1:10000).^(-2))/2);

x = GH1.allpoints;
y = abs(GH1.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'c.-','MarkerSize',16) % remove  for QuadExp2

hold on 
x = GH2.allpoints;
y = abs(GH2.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k.-.','MarkerSize',16)

x = tGKP.allpoints;
y = abs(tGKP.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'b.--','MarkerSize',16)

x = GK.allpoints;
y = abs(GK.Mean{1} - test_value);
n = length(x);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'r.:','MarkerSize',16)


x = double(GK.oldpoints);
n = length(x);
y = 1./x.^(.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.','LineWidth',2)




%% maxmum level 
figure
load QuadExpAlpha1Priori
subplot(2,1,1)
level = GH1.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'rx-')   
hold on 

load QuadExpAlpha1

level = GH1.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'ko-')   
legend('priori','posteriori')
xlabel('dimension (GH1)')
ylabel('level')
axis([1,1e4,0,8])
set(gca,'FontSize',16)


load QuadExpAlpha1Priori
subplot(2,1,2)
level = GH2.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'rx-')   
hold on 

load QuadExpAlpha1

level = GH2.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'ko-')   
legend('priori','posteriori')
xlabel('dimension (GH2)')
ylabel('level')
axis([1,1e4,0,6])
set(gca,'FontSize',16)
saveas(gca,'GH1GH2LevelAlpha1.eps','epsc')


figure
% tGKP
load QuadExpAlpha1Priori
subplot(2,1,1)
level = tGKP.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'rx-')   
hold on 

load QuadExpAlpha1

level = tGKP.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'ko-')   
legend('priori','posteriori')
xlabel('dimension (tGKP)')
ylabel('level')
axis([1,1e4,0,6])
set(gca,'FontSize',16)


% GK
load QuadExpAlpha1Priori
subplot(2,1,2)
level = GK.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'rx-')   
hold on 

load QuadExpAlpha1

level = GK.maxLevel;
location = find(diff(level)~=0);
x = [];
y = [];
if location(1) ~= 1
    x = [1];
    y = level(1);
end
for i = 1:length(location)
    x = [x, [location(i), location(i)+1]];
    y = [y, [level(location(i)), level(location(i)+1)]];
end
if location(end)+1 ~= length(level)
    x = [x, length(level)];
    y = [y, 1];
end
x = [x, x(end)+1, 1e4];
y = [y, 0, 0];
semilogx(x,y,'ko-')   
legend('priori','posteriori')
xlabel('dimension (GK)')
ylabel('level')
axis([1,1e4,0,4])
set(gca,'FontSize',16)

saveas(gca,'tGKPGKLevelAlpha1.eps','epsc')


%%




% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % semilogx([GH1.maxLevel,zeros(1,1e4-length(GH1.maxLevel))],'r.-','MarkerSize',10)
% xlabel('dimension (GH1 priori)')
% ylabel('level')
% axis([1,1e4,0,25])
% set(gca,'FontSize',16)
% 
% load QuadExpAlpha1
% subplot(2,1,2)
% semilogx([GH1.maxLevel,zeros(1,1e4-length(GH1.maxLevel))],'k.-','MarkerSize',10)
% xlabel('dimension (GH1 posteriori)')
% ylabel('level')
% axis([1,1e4,0,25])
% set(gca,'FontSize',16)
% saveas(gcf,'GH1LevelAlpha1.eps','epsc')
% 
% figure
% load QuadExpAlpha1Priori
% subplot(2,1,1)
% semilogx([GH2.maxLevel,zeros(1,1e4-length(GH2.maxLevel))],'r.-','MarkerSize',10)
% xlabel('dimension (GH2 priori)')
% ylabel('level')
% axis([1,1e4,0,6])
% set(gca,'FontSize',16)
% 
% load QuadExpAlpha1
% subplot(2,1,2)
% semilogx([GH2.maxLevel,zeros(1,1e4-length(GH2.maxLevel))],'k.-','MarkerSize',10)
% xlabel('dimension (GH2 posteriori)')
% ylabel('level')
% axis([1,1e4,0,6])
% set(gca,'FontSize',16)
% saveas(gcf,'GH2LevelAlpha1.eps','epsc')
% 
% figure
% load QuadExpAlpha1Priori
% subplot(2,1,1)
% semilogx([tGKP.maxLevel,zeros(1,1e4-length(tGKP.maxLevel))],'r.-','MarkerSize',10)
% xlabel('dimension (tGKP priori)')
% ylabel('level')
% axis([1,1e4,0,6])
% set(gca,'FontSize',16)
% 
% load QuadExpAlpha1
% subplot(2,1,2)
% semilogx([tGKP.maxLevel,zeros(1,1e4-length(tGKP.maxLevel))],'k.-','MarkerSize',10)
% xlabel('dimension (tGKP posteriori)')
% ylabel('level')
% axis([1,1e4,0,6])
% set(gca,'FontSize',16)
% saveas(gcf,'tGKPLevelAlpha1.eps','epsc')
% 
% figure
% load QuadExpAlpha1Priori
% subplot(2,1,1)
% semilogx([GK.maxLevel,zeros(1,1e4-length(GK.maxLevel))],'r.-','MarkerSize',10)
% xlabel('dimension (GK priori)')
% ylabel('level')
% axis([1,1e4,0,4])
% set(gca,'FontSize',16)
% 
% load QuadExpAlpha1
% subplot(2,1,2)
% semilogx([GK.maxLevel,zeros(1,1e4-length(GK.maxLevel))],'k.-','MarkerSize',10)
% xlabel('dimension (GK posteriori)')
% ylabel('level')
% axis([1,1e4,0,4])
% set(gca,'FontSize',16)
% saveas(gcf,'GKLevelAlpha1.eps','epsc')