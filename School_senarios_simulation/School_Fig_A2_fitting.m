%% Plot the data fitting results

load school_fit_1226

N_plot=Num_fit;
N_plot2=Num_fit;
fig1=figure(1);clf 
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'position',[0 0 0.95 0.95]); 
subplot(3,2,1)
plot(1:Num_data,CumI_ga(1:Num_data,1),'o','color',[0.74 0.56 0.56]) 
hold on
plot(1:Num_data,cumIga_model(1:Num_data,1),'-r','linewidth',2)
title('A','position',[1,40000])
ylabel('Cumulative cases of adults') 
xlim([1 Num_data])
ylim([10000 40000])
yticks([10000 20000 30000 40000])
yticklabels({'10k','20k','30k','40k'})
xticks([1 30 60 90 116])
xticklabels({'Jul 31','Aug 29','Sep 28','Oct 28','Nov 23'})
%grid on
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
subplot(3,2,3)
plot(1:Num_data,CumI_gc(1:Num_data,1),'o','color',[0.53 0.81 0.92]) 
hold on
plot(1:Num_data,cumIgc_model(1:Num_data,1),'-','linewidth',2,'color',[0 0.447 0.741])
% xlabel('Date') 
ylabel('Cumulative cases of C&Y ') 
xlim([1 Num_data])
xticks([1 30 60 90 116])
xticklabels({'Jul 31','Aug 29','Sep 28','Oct 28','Nov 23'})
ylim([1000 5000])
yticks([1000 2000 3000 4000 5000])
yticklabels({'1k','2k','3k','4k','5k'})
title('C','position',[1,5000])
%grid on
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
subplot(3,2,5)
plot(1:Num_data,CumD(1:Num_data,1),'o','color',[0.5 0.5 0.5]) 
hold on
plot(1:Num_data,CumD_model(1:Num_data,1),'-k','linewidth',2)
% xlabel('Date') 
ylabel('Cumulative death') 
xlim([1 Num_data])
xticks([1 30 60 90 116])
xticklabels({'Jul 31','Aug 29','Sep 28','Oct 28','Nov 23'})
ylim([1260 1600])
yticks([1300 1400 1500 1600])
yticklabels({'1.3k','1.4k','1.5k','1.6k'})
title('E','position',[1,1600])
%grid on
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
% print('-f1','-djpeg','-r600','./school_plot_1203/School_Fig1_fit.jpeg')

subplot(3,2,2)
plot(1:Num_data,Inew_ga(1:Num_data,1),'o','color',[0.74 0.56 0.56]) 
hold on
plot(1:Num_data,Ia2_newt(1:Num_data,1),'-r','linewidth',2)
% hold on
% plot(1:Num_data_update,Ia_newt_total(1:Num_data_update,1),'-','linewidth',2)
title('B','position',[1,600])
ylabel('Daily new cases of adults') 
xlim([1 Num_data])
% ylim([10000 45000])
% yticks([10000 15000 20000 25000 30000 35000 40000 45000])
% yticklabels({'10000','15000','20000','25000','30000','35000','40000','45000'})
xticks([1 30 60 90 116])
xticklabels({'Jul 31','Aug 29','Sep 28','Oct 28','Nov 23'})
%grid on
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
subplot(3,2,4)
plot(1:Num_data,Inew_gc(1:Num_data,1),'o','color',[0.53 0.81 0.92]) 
hold on
plot(1:Num_data,Ic2_newt(1:Num_data,1),'-','linewidth',2,'color',[0 0.447 0.741])
% hold on
% plot(1:Num_data_update,Ic_newt_total(1:Num_data_update,1),'-','linewidth',2)
% xlabel('Date') 
ylabel('Daily new cases of C&Y ') 
xlim([1 Num_data])
xticks([1 30 60 90 116])
xticklabels({'Jul 31','Aug 29','Sep 28','Oct 28','Nov 23'})
title('D','position',[1,100])
%grid on
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
%print('-f1','-djpeg','-r600','./School_plot_revision/School_Fig_A2.jpeg')
% saveas(gcf,'./School_plot_revision/School_Fig_A2.fig')