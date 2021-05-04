%% Plot the Rt contour plot
% different beta_q and contact rate

%import data, calculated by the EpiEstim package in R
Tor_R0_ga= readmatrix('Rt_QC2_withSchoolOpen_ga');
Tor_R0_gc= readmatrix('Rt_QC2_withSchoolOpen_gc');


beta_q_sim=0.005:0.0025:0.025;
ca_sim=3:0.5:10;

[X,Y] = meshgrid(ca_sim,beta_q_sim);
figure(3);clf
mesh(X,Y,Tor_R0_ga(:,2:16))
colorbar

save Rt_contour_QC2
% Plot two-parameters 
figure(3);clf
subplot(2,2,1)
contour(X,Y,Tor_R0_ga(:,2:16),'ShowText','on')
colormap(parula)
% colorbar
text(7.8-0.4,0.0085-0.0006,'*','color','r','FontSize',40)
yticks([0.005 0.01 0.015 0.02 0.025])
yticklabels({'0.5%','1%','1.5%','2%','2.5%'})
xlabel('Contact rate(adult)')
ylabel('Home transmission risk')
title('A  R_t of adult population on Oct 5,2020')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
hold on
contour(X,Y,Tor_R0_ga(:,2:16),[1 1],'ShowText','on','color','r','linewidth',3.0)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
subplot(2,2,2)
contour(X,Y,Tor_R0_gc(:,2:16),'ShowText','on')
colormap(parula)
% colorbar
text(7.8-0.4,0.0085-0.0006,'*','color','r','FontSize',40)
yticks([0.005 0.01 0.015 0.02 0.025])
yticklabels({'0.5%','1%','1.5%','2%','2.5%'})
xlabel('Contact rate(adult)')
ylabel('Home transmission risk')
title('B  R_t of children and youth on Oct 5,2020')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
hold on
contour(X,Y,Tor_R0_gc(:,2:16),[1 1],'ShowText','on','color','r','linewidth',3.0)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)

Tor_R0_ga= readmatrix('Rt_BC2_withSchoolOpen_ga');
Tor_R0_gc= readmatrix('Rt_BC2_withSchoolOpen_gc');


beta_q_sim=0.025:0.005:0.065;
beta_a_sim=3:0.5:10;

[X,Y] = meshgrid(beta_a_sim,beta_q_sim);
% figure(3);clf
% mesh(X,Y,Tor_R0_ga(:,2:10))
% colorbar
% 
% save Rt_contour_QC2
% % Plot two-parameters 
% figure(1);clf
subplot(2,2,3)
contour(X,Y,Tor_R0_ga(:,2:16),'ShowText','on')
colormap(parula)
% colorbar
text(7.8-0.4,0.041-0.001,'*','color','r','FontSize',40)
yticks([0.03 0.04 0.05 0.06])
yticklabels({'3%','4%','5%','6%'})
xlabel('Contact rate(adult)')
ylabel('Per contact transmission probability')
title('C  R_t of adult population on Oct 5,2020')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
hold on
contour(X,Y,Tor_R0_ga(:,2:16),[1 1],'ShowText','on','color','r','linewidth',3.0)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
subplot(2,2,4)
contour(X,Y,Tor_R0_gc(:,2:16),'ShowText','on')
colormap(parula)
% colorbar
text(7.8-0.4,0.041-0.001,'*','color','r','FontSize',40)
% xticks([0.015 0.02 0.025 0.03 0.035])
% xticklabels({'0.75%','1%','1.25%','1.5%','1.75%'})
yticks([0.03 0.04 0.05 0.06])
yticklabels({'3%','4%','5%','6%'})
xlabel('Contact rate(adult)')
ylabel('Per contact transmission probability')
title('D  R_t of C&Y population on Oct 5,2020')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
hold on
contour(X,Y,Tor_R0_gc(:,2:16),[1 1],'ShowText','on','color','r','linewidth',3.0)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
% print('-f3','-djpeg','-r600','./School_plot_revision/School_Fig3.jpeg')
% saveas(gcf,'./School_plot_revision/School_Fig3.fig')
sound(sin(2*pi*25*(1:4000)/100));