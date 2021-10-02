% index plot function
x = 1:7;
[x,y] = meshgrid(x)

plot(x,y,'kx','MarkerSize',20)
axis square
grid on
box on
saveas(gcf,'/home/peng/Dropbox/Talk/2014-01-2829-02-13_CMCS/figure/TPindex.eps','epsc')
clear all

figure(2)
for x = 1:7
    for y = 1:7
        if x+y<=8
            hold on
            plot(x,y,'kx','MarkerSize',20)
        end
    end
end
axis square
grid on
box on
saveas(gcf,'/home/peng/Dropbox/Talk/2014-01-2829-02-13_CMCS/figure/TDindex.eps','epsc')
clear all

figure(3)
axis([1,14,1,14])
for x = 1:14
    for y = 1:14
        if x+1.5*y<=15
            hold on 
            plot(x,y,'kx','MarkerSize',20)
        end
    end
end

axis square

grid on
box on
saveas(gcf,'/home/peng/Dropbox/Talk/2014-01-2829-02-13_CMCS/figure/anisoTDindex14.eps','epsc')
clear all
