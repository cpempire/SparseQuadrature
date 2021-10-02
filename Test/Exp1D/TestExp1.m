%% test accuracy of different quadrature rule 
accuracy_kpu = [1,3,6,12,24,25];
accuracy_kpn = [1,3,8,15]; %25% order of accuracy 
accuracy_ghn = 1:13;%[1,3,7,15,31,63]; % # points 


f = @test_exp1;%
Data.gridType = 'gauss-hermite';

for dim = 0
    clear value_u mean_u node_u
    for ia = 1:length(accuracy_kpu)
        [x, w] = nwspgr('KPU', 1, accuracy_kpu(ia));
        for ix = 1:length(x)
            value_u(ix) = feval(f,icdf('normal',[0.5*ones(1,dim),x(ix)],0,1),Data);
        end
        mean_u(ia) = value_u*w;
        node_u(ia) = length(x);
    end

    
    clear value_n mean_n node_n
    for ia = 1:length(accuracy_kpn)
        [x, w] = nwspgr('KPN', 1, accuracy_kpn(ia));
        for ix = 1:length(x)
            value_n(ix) = feval(f,[zeros(1,dim),x(ix)],Data);
        end
        mean_n(ia) = value_n*w;
        node_n(ia) = length(x);
    end
    
    clear value_g mean_g node_g
    for ia = 1:length(accuracy_ghn)
        [x, w] =  GaussHermite(accuracy_ghn(ia));
        x = sqrt(2)*x;
        for ix = 1:length(x)
            value_g(ix) = feval(f,[zeros(1,dim),x(ix)],Data);
        end
        mean_g(ia) = value_g*w;
        node_g(ia) = length(x);
    end
    
%     subplot(1,2,1)
%     plot(x,value_g,'.-');
%     
%     subplot(1,2,2)
    figure
    semilogy(node_g(1:end-1),abs(mean_g(1:end-1) - mean_g(end)),'cx-')
    hold on 
    semilogy(node_u(1:end),abs(mean_u(1:end) - mean_g(end)),'b*-')
    semilogy(node_n(1:end),abs(mean_n(1:end) - mean_g(end)),'r.-','MarkerSize',10)
    legend('GH1','tGKP','GK')
    axis([0,70,1e-16,1])
    xlabel('$m_l$','Interpreter','latex')
    ylabel('$|I(f) - \mathcal{Q}_l(f)|$','Interpreter','latex')
    set(gca,'FontSize',16)
    saveas(gca,'QuadExp1D1','epsc')
end

accuracy_kpn = [1,3,8]; % order of accuracy 
accuracy_ghn = 1:5;%[1,3,7,15,31,63]; % # points 
for dim = 99
    clear value_u mean_u node_u
    for ia = 1:length(accuracy_kpu)
        [x, w] = nwspgr('KPU', 1, accuracy_kpu(ia));
        for ix = 1:length(x)
            value_u(ix) = feval(f,icdf('normal',[0.5*ones(1,dim),x(ix)],0,1),Data);
        end
        mean_u(ia) = value_u*w;
        node_u(ia) = length(x);
    end

    
    clear value_n mean_n node_n
    for ia = 1:length(accuracy_kpn)
        [x, w] = nwspgr('KPN', 1, accuracy_kpn(ia));
        for ix = 1:length(x)
            value_n(ix) = feval(f,[zeros(1,dim),x(ix)],Data);
        end
        mean_n(ia) = value_n*w;
        node_n(ia) = length(x);
    end
    
    clear value_g mean_g node_g
    for ia = 1:length(accuracy_ghn)
        [x, w] =  GaussHermite(accuracy_ghn(ia));
        x = sqrt(2)*x;
        for ix = 1:length(x)
            value_g(ix) = feval(f,[zeros(1,dim),x(ix)],Data);
        end
        mean_g(ia) = value_g*w;
        node_g(ia) = length(x);
    end
    
%     subplot(1,2,1)
%     plot(x,value_g,'.-');
%     
%     subplot(1,2,2)
    figure
    semilogy(node_g(1:end-1),abs(mean_g(1:end-1) - mean_g(end)),'cx-')
    hold on 
    semilogy(node_u(1:end),abs(mean_u(1:end) - mean_g(end)),'b*-')
    semilogy(node_n(1:end),abs(mean_n(1:end) - mean_g(end)),'r.-','MarkerSize',10)
    legend('GH1','tGKP','GK')
    
    xlabel('$m_l$','Interpreter','latex')
    ylabel('$|I(f) - \mathcal{Q}_l(f)|$','Interpreter','latex')
    set(gca,'FontSize',16)
    saveas(gca,'QuadExp1D100.eps','epsc')
end