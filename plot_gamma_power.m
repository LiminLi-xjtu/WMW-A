%%%%%%%%%%%%%%%%%%%%%%%%% plot the he distributions of the populations X and Y %%%%%%%%%%%%%%%%%%%%%%%%%%
clear
load('result_balanced.mat')
figure(1)

x = gamrnd(alpha_1,beta,1,10000);
for s = 1:length(alpha_2)
    y = gamrnd(alpha_2(s),beta,1,10000);
    
    subplot(length(alpha_2),1,s)
    
    t1 = 0:0.1:7;
    alpha2 = alpha_2(s);
    f1 = beta.^alpha_1*(t1.^(alpha_1-1)).*exp(-beta*t1)/gamma(alpha_1);
    f2 = beta.^alpha2*(t1.^(alpha2-1)).*exp(-beta*t1)/gamma(alpha2);
    
    set(gca,'XLim',[0,7])
    set(gca,'XLim',[0,7])
    
    plot(t1,f1,'-.','color',[38 178 75]/255,'MarkerSize',4.5,'LineWidth',1.1)
    hold on
    plot(t1,f2,'-','color',[242 116 108]/255,'MarkerSize',4.5,'LineWidth',1.1)
    
    set(gca,'Fontname','Times New Roman','FontWeight','bold')
    title(['\delta=' num2str(alpha_2(s)-alpha_1)],'Fontname','Times New Roman','FontWeight','bold')
    xlabel('x','Fontname','Times New Roman','FontWeight','bold')
    ylabel('f(x)','Fontname','Times New Roman','FontWeight','bold');
    legend(['\alpha_1=',num2str(alpha_1)],['\alpha_2=',num2str(alpha2)],'Fontname','Times New Roman','FontWeight','bold','location','NorthEast');
    grid on
    set(gcf,'unit','centimeters','position',[0 0 7 26])
end


%%%%%%%%%%%%%%%%%%%%%%%%% plot the balanced case %%%%%%%%%%%%%%%%%%%%%%%%%%
clear
load('result_balanced.mat')
figure(2)
for s = 1:length(alpha_2)
    subplot(length(alpha_2),1,s)
    
    plot(n_list,power_t(s,:),':.','color',[38 178 75]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
    plot(n_list,power_wmw(s,:),'--','color',[255 169 11]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on 
    plot(n_list,power_wmwa(s,:,1),'-x','color',[110 147 204]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
    plot(n_list,power_wmwa(s,:,2),'-*','color',[242 116 108]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
    plot(n_list,power_wmwa(s,:,3),'k-.','MarkerSize',4.5,'LineWidth',1.1); hold on
    
    set(gca,'Fontname','Times New Roman','FontWeight','bold')
    xlabel('n','Fontname','Times New Roman','FontWeight','bold')
    ylabel('Power','Fontname','Times New Roman','FontWeight','bold');
    title(['balanced (m=n)'],'Fontname','Times New Roman','FontWeight','bold')
    legend('t-test','WMW','WMW-A(k=2)','WMW-A(k=5)','WMW-A(k=10)','Fontname','Times New Roman','FontWeight','bold','location','SouthEast');
    grid on
    set(gca,'XLim',[0,25]);
    set(gcf,'unit','centimeters','position',[0 0 7 26])
end


%%%%%%%%%%%%%%%%%%%%%%%%%% plot the unbalanced case %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear
% load('result_unbalanced.mat')
% figure(3)
% for s = 1:length(alpha_2)
%     subplot(length(alpha_2),1,s)
%     
%     plot(n_list,power_t(alpha_2(s),:),':.','color',[38 178 75]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
%     plot(n_list,power_wmw(alpha_2(s),:),'--','color',[255 169 11]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
%     plot(n_list,power_wmwa(alpha_2(s),:,1),'-x','color',[110 147 204]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
%     plot(n_list,power_wmwa(alpha_2(s),:,2),'-*','color',[242 116 108]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
%     plot(n_list,power_wmwa(alpha_2(s),:,3),'k-.','MarkerSize',4.5,'LineWidth',1.1); hold on
%     
%     set(gca,'Fontname','Times New Roman','FontWeight','bold')
%     xlabel('n','Fontname','Times New Roman','FontWeight','bold')
%     ylabel('Power','Fontname','Times New Roman','FontWeight','bold');
%     title(['unbalanced (m=5)'],'Fontname','Times New Roman','FontWeight','bold')
%     legend('t-test','WMW','WMW-A(k=2)','WMW-A(k=5)','WMW-A(k=10)','Fontname','Times New Roman','FontWeight','bold','location','SouthEast');
%     grid on
%     set(gca,'XLim',[10,100]);
%     set(gcf,'unit','centimeters','position',[0 0 7 26])
% end