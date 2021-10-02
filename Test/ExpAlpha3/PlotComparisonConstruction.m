%% compare goal-oriented adaptive construction and a priori construction

figure

load QuadExpAlpha3Priori
test_value = exp(sum((1:10000).^(-6))/2);

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

load QuadExpAlpha3
test_value = exp(sum((1:10000).^(-6))/2);

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

% load MCAlpha3
% loglog(2.^(0:16),sum(f_error)/100,'gs-.')

x = double(GK.oldpoints);
n = length(x);
y = 1./x.^(3);
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
       'posteriori \fontsize{16}GK','\fontsize{16}N^{-3}','Location','SouthWest')

xlabel('# points', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'OldPointsPrioriPosterioriAlpha3.eps','epsc')
%% 
figure

load QuadExpAlpha3Priori
test_value = exp(sum((1:10000).^(-6))/2);

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

load QuadExpAlpha3
test_value = exp(sum((1:10000).^(-6))/2);

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

% load MCAlpha3
% loglog(2.^(0:16),sum(f_error)/100,'gs-.')

x = 1:length(GK.oldpoints);
n = length(x);
y = 1./x.^(3);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.','LineWidth',2)

% x = 1:length(GK.oldpoints);
% n = length(x);
% y = 2./x.^(.5);
% x = x(floor(2.^(0:log2(n))));
% y = y(floor(2.^(0:log2(n))));
% loglog(x,y,'k--','LineWidth',2)
% axis([1,1e5,1e-7,1e1])
legend('priori \fontsize{16}GH1','priori \fontsize{16}GH2','priori \fontsize{16}tGKP',...
       'priori \fontsize{16}GK', ...
       'posteriori \fontsize{16}GH1','posteriori \fontsize{16}GH2','posteriori \fontsize{16}tGKP',...
       'posteriori \fontsize{16}GK','\fontsize{16}N^{-3}','Location','SouthWest')

xlabel('# indices', 'FontSize',16,'Interpreter','latex')
ylabel('$|I(f) - \mathcal{Q}_{\Lambda}(f)|$','FontSize',16,'Interpreter','latex')
set(gca,'FontSize',16)
saveas(gcf,'OldIndicesPrioriPosterioriAlpha3.eps','epsc')
%% 
figure
load QuadExpAlpha3
test_value = exp(sum((1:10000).^(-6))/2);

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

load MCAlpha3
loglog(2.^(0:16),sum(f_error)/100,'gs-.')

load QuadExpAlpha3Priori
test_value = exp(sum((1:10000).^(-6))/2);

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
y = 1./x.^(1.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k-.','LineWidth',2)

x = double(GK.oldpoints);
n = length(x);
y = 1./x.^(.5);
x = x(floor(2.^(0:log2(n))));
y = y(floor(2.^(0:log2(n))));
loglog(x,y,'k--','LineWidth',2)





figure
load QuadExpAlpha3Priori
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

load QuadExpAlpha3

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
axis([1,1e4,0,40])
set(gca,'FontSize',16)


load QuadExpAlpha3Priori
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

load QuadExpAlpha3

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
saveas(gca,'GH1GH2LevelAlpha3.eps','epsc')


figure
% tGKP
load QuadExpAlpha3Priori
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

load QuadExpAlpha3

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
load QuadExpAlpha3Priori
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

load QuadExpAlpha3

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

saveas(gca,'tGKPGKLevelAlpha3.eps','epsc')
