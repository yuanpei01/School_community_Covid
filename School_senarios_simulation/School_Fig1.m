
clear all

load S1_compare_Open_a_10
load S1_compare_Open_c_10
load S1_compare_Open_all_10
load S1_compare_schoolClose
load S1_compare_Open_phase1
load S1_compare_Open_phase2
load S1_compare_Open_phase3
load S1_compare_Open_phase4
load S1_compare_schoolClose_Phase2
load S1_compare_schoolClose_Phase3
load S1_compare_schoolClose_Phase4
load LS_data

Ia_perc_open_phase1=(Ia_newt_total_Open_phase1./Ia_newt_total_schoolClose-1)*100;
Ia_perc_open_a_10=(Ia_newt_total_Open_a_10./Ia_newt_total_schoolClose-1)*100;
Ia_perc_open_c_10=(Ia_newt_total_Open_c_10./Ia_newt_total_schoolClose-1)*100;

Ic_perc_open_phase1=(Ic_newt_total_Open_phase1./Ic_newt_total_schoolClose-1)*100;
Ic_perc_open_a_10=(Ic_newt_total_Open_a_10./Ic_newt_total_schoolClose-1)*100;
Ic_perc_open_c_10=(Ic_newt_total_Open_c_10./Ic_newt_total_schoolClose-1)*100;

Ia_perc=[Ia_perc_open_phase1(53) Ia_perc_open_c_10(53) Ia_perc_open_a_10(53);
         Ia_perc_open_phase1(67) Ia_perc_open_c_10(67) Ia_perc_open_a_10(67);
         Ia_perc_open_phase1(81) Ia_perc_open_c_10(81) Ia_perc_open_a_10(81);
         Ia_perc_open_phase1(95) Ia_perc_open_c_10(95) Ia_perc_open_a_10(95)];
Ic_perc=[Ic_perc_open_phase1(53) Ic_perc_open_c_10(53) Ic_perc_open_a_10(53);
         Ic_perc_open_phase1(67) Ic_perc_open_c_10(67) Ic_perc_open_a_10(67);
         Ic_perc_open_phase1(81) Ic_perc_open_c_10(81) Ic_perc_open_a_10(81);
         Ic_perc_open_phase1(95) Ic_perc_open_c_10(95) Ic_perc_open_a_10(95)];     

N_plot=Num_fit;
N_plot2=Num_fit;

figure(1);clf
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
set(b, {'DisplayName'}, {'Keep same transmission risk','Increasing 10% contact rate(C&Y)','Increasing 10% contact rate(adult)'}')
% Legend will show names for each color
legend('box','off') 
ylabel('The inrease of new cases of adult, compared to school close (%)') 
title('A')
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
ylabel('The inrease of new cases of C&Y, compared to school close (%)') 
title('B')
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
% print('-f1','-djpeg','-r600','./School_plot_revision/School_Fig1.jpeg')
% saveas(gcf,'./School_plot_revision/School_Fig1.fig')