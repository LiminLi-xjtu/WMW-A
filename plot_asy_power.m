clear
load 'result_asy'

figure(1);
plot(N,power_wmwa_asy(1,:,1),'--','color',[192 121 248]/255,'MarkerSize',4.5,'LineWidth',1.1); hold on
plot(N,power_wmwa2(1,:,1),'k-.','MarkerSize',4.5,'LineWidth',1.1); hold on

set(gca,'Fontname','Times New Roman','FontWeight','bold')
xlabel('n','Fontname','Times New Roman','FontWeight','bold')
ylabel('Power','Fontname','Times New Roman','FontWeight','bold');
title(['m=n'],'Fontname','Times New Roman','FontWeight','bold')
le = legend('WMW-A(Asymptotic)','WMW-A(Permutation)','Fontname','Times New Roman','FontWeight','bold');
set(le,'Position',[0.185,0.21,0.13,0.08]);
grid on