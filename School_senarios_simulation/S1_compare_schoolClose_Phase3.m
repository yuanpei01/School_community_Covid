%% comparision of differnt open control measures
% the model with age and household structure

clear all
clc
clear model data parama options

tic
format short e

load nCoV_school_param

 par10=[8.4999e-01   6.4157e-01   9.6996e-01   2.0545e-01   2.5710e-01   8.5111e-03   4.9989e-03...
       6.5118e+00   4.8930e+00   6.5002e+00...
       7.8002e+00   5.6008e+00   8.1500e+00...
       4.3531e+00   2.8005e+00   4.2630e+00...
       5.7452e+00   3.5988e+00   6.3939e+00...
       6.9998e-03   3.2006e-02   8.5004e-02];  
 
 sim_phase1=[par10(7:10)];
 sim_phase2=[par10(20) par10(11:13)];
 sim_phase3=[par10(21) par10(14:16)];
 sim_phase4=[par10(22) par10(17:19)];

 Inew_ga_0=10;
 Inew_gc_0=4;
 Dnew_0=1;
% d, c_ga, c_ac,c_cc, par1(7:10)
%---------- Separate model-----------------
Num_fit=116;% till Oct 5, 4 weeks after school, 39+28=67

% from Jul 31 - Sep 8
sc=[0;0;0;0;0];
y00=[data.params(1:10);sc;data.params(11:347)];
load y1_till_0908.mat
y01=y1(end,:);
y_total=y1;
%% after school open
% School close
par1_schoolClose_Phase3=[par10(1:6) sim_phase3];
par2(end)=0;
[t_schoolClose_Phase3,y_schoolClose_Phase32] = ode45(@NCoVGTA_Household_openSchool_sim,[39:Num_fit],y01,[],par1_schoolClose_Phase3,par2,AC,CC);
y_schoolClose_Phase3=[y_total(1:end-1,:);y_schoolClose_Phase32];

% CumD
CumD_schoolClose_Phase3=y_schoolClose_Phase3(:,21);
% CumI
CumIa_schoolClose_Phase3=y_schoolClose_Phase3(:,22);
CumIc_schoolClose_Phase3=y_schoolClose_Phase3(:,23);

%NEW infection (A+I) of time t
% Ia_newt=1/tau1*(Ega)
Ia_newt_total_schoolClose_Phase3=1/tau1.*(y_schoolClose_Phase3(:,2));
Ic_newt_total_schoolClose_Phase3=1/tau1.*(y_schoolClose_Phase3(:,7));

% New CASE (I) of time t
%I2_newt=1/tau2*(I1)
% Ia2_newt=1/tau2.*(y_total(:,4));
% Ic2_newt=1/tau2.*(y_total(:,9));
Ia2_newt_schoolClose_Phase3=[Inew_ga_0;diff(CumIa_schoolClose_Phase3)];
Ic2_newt_schoolClose_Phase3=[Inew_gc_0;diff(CumIc_schoolClose_Phase3)];
D_newt_schoolClose_Phase3=[Dnew_0;diff(CumD_schoolClose_Phase3)];

save S1_compare_schoolClose_Phase3

N_plot=Num_fit;
N_plot2=Num_fit;
figure(2);clf 
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,2,1)
plot(1:N_plot,Ia_newt_total_schoolClose_Phase3,'-','linewidth',2) 
ylabel('Daily new infections (adults, 20+)') 
legend('school open, with community partily open')
xlim([1 N_plot])
xticks([1 40 67])
xticklabels({'Jul 31','Sep 8','After 4 weeks'})
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
subplot(2,2,2)
plot(1:N_plot,Ic_newt_total_schoolClose_Phase3,'-','linewidth',2) 
legend('school open, with community partily open')
ylabel('Daily new infections (C&Y, 0-19) ') 
xlim([1 N_plot])
xticks([1 40 67])
xticklabels({'Jul 31','Sep 8','After 4 weeks'})
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
subplot(2,2,3)
plot(1:N_plot,D_newt_schoolClose_Phase3,'-','linewidth',2) 
legend('school open, with community partily open')
ylabel('Daily new death') 
xlim([1 N_plot])
xticks([1 40 67])
xticklabels({'Jul 31','Sep 8','After 4 weeks'})
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
print('-f2','-djpeg','-r600','./school_plot_revision/S1_compare_schoolClose_Phase3.jpeg')
saveas(gcf,'./school_plot_revision/S1_compare_schoolClose_Phase3.fig')
toc
sound(sin(2*pi*25*(1:4000)/100));

% tt=[0:66];
% % ttt=11.58./(1+((11.58-5)/5)*exp(-0.1*(tt)));
% ttt=0.024./(1+((0.024-0.019)/0.019)*exp(-0.08*(tt)));
% figure(7);
% plot(tt,ttt)