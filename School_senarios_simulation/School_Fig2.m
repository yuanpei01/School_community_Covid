clear all
%% load scenarios results
load S1_compare_schoolClose
load S1_compare_Open_phase1
load S1_compare_Open_phase2
load S1_compare_Open_phase3
load S1_compare_Open_phase4
load S1_compare_schoolClose_Phase2
load S1_compare_schoolClose_Phase3
load S1_compare_schoolClose_Phase4
load LS_data

N_plot=Num_fit;
N_plot2=Num_fit;
figure(2);clf 
subplot(1,2,1)
% plot(1:39,Ia_newt_total_schoolClose(1:39),'-','linewidth',2) 
% hold on
h1=plot(1:N_plot,Ia_newt_total_schoolClose,'--','linewidth',2,'color',[0 0.447 0.741]) 
hold on
h2=plot(1:N_plot,Ia_newt_total_Open_phase1,'-','linewidth',2,'color',[0 0.447 0.741]) 
hold on
h3=plot(1:N_plot,Ia_newt_total_schoolClose_Phase2,'--','linewidth',2,'color',[0.85 0.325 0.098]) 
hold on
h4=plot(1:N_plot,Ia_newt_total_Open_phase2,'-','linewidth',2,'color',[0.85 0.325 0.098]) 
hold on
h5=plot(1:N_plot,Ia_newt_total_schoolClose_Phase3,'--','linewidth',2,'color',[0.466 0.674 0.188]) 
hold on
h6=plot(1:N_plot,Ia_newt_total_Open_phase3,'-','linewidth',2,'color',[0.466 0.674 0.188]) 
hold on
h7=plot(1:N_plot,Ia_newt_total_schoolClose_Phase4,'--','linewidth',2,'color',[0.494 0.184 0.556]) 
hold on
h8=plot(1:N_plot,Ia_newt_total_Open_phase4,'-','linewidth',2,'color',[0.494 0.184 0.556]) 
hold on
plot(1:39,Ia_newt_total_schoolClose(1:39),'-','linewidth',2,'color',[0.301 0.745 0.933]) 
hold on
h9=plot(1:95, Inew_ga(1:95),'*')
ylabel('Daily new cases (adults, 20+)') 
title('A')
legend([h1 h2 h3 h4 h5 h6 h7 h8 h9],'School close, phase 1', 'School open, phase 1','School close, phase 2','School open, phase 2','School close, phase 3','School open, phase 3','School close, phase 4','School open, phase 4','data','box','off','NumColumns',5)
xlim([1 95])
ylim([0 800])
xticks([1 40 67 95])
xticklabels({'Jul 31','Sep 8','After 4 weeks','After 8 weeks'})
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
subplot(1,2,2)
plot(1:N_plot,Ic_newt_total_schoolClose,'--','linewidth',2,'color',[0 0.447 0.741]) 
hold on
plot(1:N_plot,Ic_newt_total_Open_phase1,'-','linewidth',2,'color',[0 0.447 0.741]) 
hold on
plot(1:N_plot,Ic_newt_total_schoolClose_Phase2,'--','linewidth',2,'color',[0.85 0.325 0.098]) 
hold on
plot(1:N_plot,Ic_newt_total_Open_phase2,'-','linewidth',2,'color',[0.85 0.325 0.098]) 
hold on
plot(1:N_plot,Ic_newt_total_schoolClose_Phase3,'--','linewidth',2,'color',[0.466 0.674 0.188]) 
hold on
plot(1:N_plot,Ic_newt_total_Open_phase3,'-','linewidth',2,'color',[0.466 0.674 0.188]) 
hold on
plot(1:N_plot,Ic_newt_total_schoolClose_Phase4,'--','linewidth',2,'color',[0.494 0.184 0.556]) 
hold on
plot(1:N_plot,Ic_newt_total_Open_phase4,'-','linewidth',2,'color',[0.494 0.184 0.556]) 
hold on
plot(1:39,Ic_newt_total_schoolClose(1:39),'-','linewidth',2,'color',[0.301 0.745 0.933]) 
hold on
plot(1:95, Inew_gc(1:95),'*')
ylabel('Daily new cases (C&Y, 0-19) ') 
title('B')
xlim([1 95])
ylim([0 120])
xticks([1 40 67 95])
xticklabels({'Jul 31','Sep 8','After 4 weeks','After 8 weeks'})
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
print('-f2','-djpeg','-r600','./School_plot_revision/School_Fig2.jpeg')
saveas(gcf,'./School_plot_revision/School_Fig2.fig')