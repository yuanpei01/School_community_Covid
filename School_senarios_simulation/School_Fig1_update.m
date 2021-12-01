
clear all

load S1_compare_Open_a_10
load S1_compare_Open_c_10
load S1_compare_Open_c_50
load S1_compare_Open_all_10
load S1_compare_schoolClose
load S1_compare_Open_phase1
load S1_compare_Open_phase2
load S1_compare_Open_phase3
load S1_compare_Open_phase4
load S1_compare_schoolClose_Phase2
load S1_compare_schoolClose_Phase3
load S1_compare_schoolClose_Phase4
% load S1_compare_Open_phase23
% load S1_compare_Open_phase33
% load S1_compare_Open_phase43

Tor = xlsread('Toronto_0731_1123'); %function NCoVdata: construct dataset
Inew_ga=Tor(:,4);
Inew_gc=Tor(:,3);
CumI_ga=Tor(:,5);  %Total cumulative Infection of children population Jul 31 - Dec 26
CumI_gc=Tor(:,6); 
Num_data=length(CumI_gc);

Ia_scenarios=round([Ia_newt_total_schoolClose Ia_newt_total_Open_phase1 Ia_newt_total_Open_a_10 Ia_newt_total_Open_c_50...
              Ia_newt_total_schoolClose_Phase2 Ia_newt_total_Open_phase2 Ia_newt_total_schoolClose_Phase3 Ia_newt_total_Open_phase3...
              Ia_newt_total_schoolClose_Phase4 Ia_newt_total_Open_phase4]);
          
Ic_scenarios=round([Ic_newt_total_schoolClose Ic_newt_total_Open_phase1 Ic_newt_total_Open_a_10 Ic_newt_total_Open_c_50...
              Ic_newt_total_schoolClose_Phase2 Ic_newt_total_Open_phase2 Ic_newt_total_schoolClose_Phase3 Ic_newt_total_Open_phase3...
              Ic_newt_total_schoolClose_Phase4 Ic_newt_total_Open_phase4]);

Ia_selected=Ia_scenarios([53 67 81 95],:)';    
Ic_selected=Ic_scenarios([53 67 81 95],:)';   

Inew_output=[Ia_selected Ic_selected];
          
Ia_perc_open_phase1=(Ia_newt_total_Open_phase1./Ia_newt_total_schoolClose-1)*100;
Ia_perc_open_a_10=(Ia_newt_total_Open_a_10./Ia_newt_total_schoolClose-1)*100;
Ia_perc_open_c_10=(Ia_newt_total_Open_c_10./Ia_newt_total_schoolClose-1)*100;
Ia_perc_open_c_50=(Ia_newt_total_Open_c_50./Ia_newt_total_schoolClose-1)*100;

Ic_perc_open_phase1=(Ic_newt_total_Open_phase1./Ic_newt_total_schoolClose-1)*100;
Ic_perc_open_a_10=(Ic_newt_total_Open_a_10./Ic_newt_total_schoolClose-1)*100;
Ic_perc_open_c_10=(Ic_newt_total_Open_c_10./Ic_newt_total_schoolClose-1)*100;
Ic_perc_open_c_50=(Ic_newt_total_Open_c_50./Ic_newt_total_schoolClose-1)*100;


Ia_perc=[Ia_perc_open_phase1(53) Ia_perc_open_c_50(53) Ia_perc_open_a_10(53);
         Ia_perc_open_phase1(67) Ia_perc_open_c_50(67) Ia_perc_open_a_10(67);
         Ia_perc_open_phase1(81) Ia_perc_open_c_50(81) Ia_perc_open_a_10(81);
         Ia_perc_open_phase1(95) Ia_perc_open_c_50(95) Ia_perc_open_a_10(95)];
Ic_perc=[Ic_perc_open_phase1(53) Ic_perc_open_c_50(53) Ic_perc_open_a_10(53);
         Ic_perc_open_phase1(67) Ic_perc_open_c_50(67) Ic_perc_open_a_10(67);
         Ic_perc_open_phase1(81) Ic_perc_open_c_50(81) Ic_perc_open_a_10(81);
         Ic_perc_open_phase1(95) Ic_perc_open_c_50(95) Ic_perc_open_a_10(95)];     

N_plot=Num_fit;
N_plot2=Num_fit;
figure(1);clf 
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
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
ylabel('Daily new infections (adults, 20+)') 
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
ylabel('Daily new infections (C&Y, 0-19) ') 
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
% subplot(2,2,3)
% plot(1:N_plot,CumD_schoolClose,'-','linewidth',2) 
% hold on
% plot(1:N_plot,CumD_Open_phase1,'-','linewidth',2) 
% hold on
% plot(1:N_plot,CumD_Open_phase2,'-','linewidth',2) 
% hold on
% plot(1:N_plot,CumD_Open_phase3,'-','linewidth',2) 
% hold on
% plot(1:N_plot,CumD_Open_phase4,'-','linewidth',2) 
% ylabel('Daily new death') 
% xlim([1 N_plot])
% xticks([1 40 67])
% xticklabels({'Jul 31','Sep 8','After 4 weeks'})
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% %set(gca,'GridLineStyle',':');
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)

% figure(2);clf 
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% subplot(1,2,1)
% % plot(1:39,Ia_newt_total_schoolClose(1:39),'-','linewidth',2) 
% % hold on
% % h1=plot(1:N_plot,Ia_newt_total_schoolClose,'--','linewidth',2,'color',[0 0.447 0.741]) 
% % hold on
% h2=plot(1:N_plot,Ia_perc_open_phase1,'-','linewidth',2,'color',[0 0.447 0.741]) 
% hold on
% h3=plot(1:N_plot,Ia_perc_open_a_10,'-','linewidth',2,'color',[0.85 0.325 0.098]) 
% hold on
% h4=plot(1:N_plot,Ia_perc_open_c_10,'-','linewidth',2,'color',[0.929 0.694 0.125]) 
% % hold on
% % h5=plot(1:N_plot,Ia_newt_total_Open_all_10,'-','linewidth',2,'color',[0.635 0.078 0.184]) 
% % hold on
% % plot(1:39,Ia_newt_total_schoolClose(1:39),'-','linewidth',2,'color',[0.301 0.745 0.933]) 
% ylabel('Daily new infections (adults, 20+)') 
% title('A')
% % legend([h1 h2 h3 h4 h5],'School close', 'School open, keep same transmission risk','School open, increasing 10% transmission risk (adult)','School open, increasing 10% transmission risk (C&Y)','School open, increasing 10% transmission risk (all)','box','off','NumColumns',3)
% % legend([h2 h3 h4],'School open, keep same transmission risk','School open, increasing 10% transmission risk (adult)','School open, increasing 10% transmission risk (C&Y)','box','off','NumColumns',3)
% xlim([1 81])
% % xlim([1 95])
% xticks([1 40 67 95])
% xticklabels({'Jul 31','Sep 8','After 4 weeks','After 8 weeks'})
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% %set(gca,'GridLineStyle',':');
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% subplot(1,2,2)
% % plot(1:N_plot,Ic_newt_total_schoolClose,'--','linewidth',2,'color',[0 0.447 0.741]) 
% % hold on
% plot(1:N_plot,Ic_perc_open_phase1,'-','linewidth',2,'color',[0 0.447 0.741]) 
% hold on
% plot(1:N_plot,Ic_perc_open_a_10,'-','linewidth',2,'color',[0.85 0.325 0.098]) 
% hold on
% plot(1:N_plot,Ic_perc_open_c_10,'-','linewidth',2,'color',[0.929 0.694 0.125]) 
% % hold on
% % plot(1:N_plot,Ic_newt_total_Open_all_10,'-','linewidth',2,'color',[0.635 0.078 0.184]) 
% % hold on
% % plot(1:39,Ic_newt_total_schoolClose(1:39),'-','linewidth',2,'color',[0.301 0.745 0.933]) 
% ylabel('Daily new infections (C&Y, 0-19) ') 
% xlim([1 81])
% % xlim([1 95])
% xticks([1 40 67 95])
% xticklabels({'Jul 31','Sep 8','After 4 weeks','After 8 weeks'})
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% %set(gca,'GridLineStyle',':');
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)

figure(3);clf
subplot(1,2,1)
X = categorical({'2 weeks','4 weeks','6 weeks','8 weeks'});
X = reordercats(X,{'2 weeks','4 weeks','6 weeks','8 weeks'});
b=bar(X,Ia_perc)
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(roundn(b(1).YData,-1));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(roundn(b(2).YData,-1));
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips3 = b(3).XEndPoints;
ytips3 = b(3).YEndPoints;
labels3 = string(roundn(b(3).YData,-1));
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
% set 3 display names for the 3 handles
set(b, {'DisplayName'}, {'School open, keep same transmission risk','School open, increasing 50% contact rate(C&Y)','School open, increasing 10% contact rate(adult)'}')
% Legend will show names for each color
legend('box','off') 
ylabel('The inrease of new infection of adult, compared to school close (%)') 
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',1.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

subplot(1,2,2)
X = categorical({'2 weeks','4 weeks','6 weeks','8 weeks'});
X = reordercats(X,{'2 weeks','4 weeks','6 weeks','8 weeks'});
b=bar(X,Ic_perc)
xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(roundn(b(1).YData,-1));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(roundn(b(2).YData,-1));
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips3 = b(3).XEndPoints;
ytips3 = b(3).YEndPoints;
labels3 = string(roundn(b(3).YData,-1));
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
% set 3 display names for the 3 handles
% set(b, {'DisplayName'}, {'Keep same transmission risk','Increasing 10% contact rate(C&Y)','Increasing 10% contact rate(adult)'}')
% % Legend will show names for each color
% legend('box','off') 
ylabel('The inrease of new infection of C&Y, compared to school close (%)') 
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',1.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
%set(gca,'GridLineStyle',':');
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
% print('-f3','-djpeg','-r600','./school_plot_revision/School_Fig1_3.jpeg')
% print('-f2','-djpeg','-r600','./school_plot_revision/School_Fig2_2.jpeg')
% saveas(gcf,'./school_plot_revision/School_Fig1.fig')