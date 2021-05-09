%% different contact rate before and after school reopen
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
 sim_a_10=[par10(7) par10(8)*1.1 par10(9:10)];
 sim_all_10=[par10(7) 1.1*par10(8:10)];

 Inew_ga_0=10;
 Inew_gc_0=4;
 Dnew_0=1;
 
beta_g_sim=0.025:0.005:0.065;
ca2_sim=3:0.5:10;
L_T=length(beta_g_sim);
L_Q=length(ca2_sim);

new_I_ga=zeros(L_T,L_Q);
new_I_gc=zeros(L_T,L_Q);
new_I=zeros(L_T,L_Q);
new_infection_ga=cell(L_T,L_Q);
new_infection_gc=cell(L_T,L_Q);
% d, c_ga, c_ac,c_cc, par1(7:10)
%---------- Separate model-----------------
Num_fit=95;% till Oct 5, 4 weeks after school, 39+28=67
parfor j=1:L_T
    for k=1:L_Q
par1_Open=[par10(1:6) par10(21) par10(8:10)];
% from Jul 31 - Sep 8
sc=[0;0;0;0;0];
y00=[data.params(1:10);sc;data.params(11:347)];
[t1,y1] = ode45(@NCoVGTA_Household_openSchool_sim,[1:T1],y00,[],par1_Open,par2,AC,CC); 
y01=y1(end,:);
%% after school open
% School close
par2_open=par2;
par2_open(12)=beta_g_sim(j);
par1_Open_2=[par10(1:6) par10(21) ca2_sim(k) par10(9:10)];

[t2,y2] = ode45(@NCoVGTA_Household_openSchool_sim,[T1:Num_fit],y01,[],par1_Open_2,par2_open,AC,CC); 


y_close=[y1(1:T1-1,:);y2(1:end,:)];

% CumD
CumD_Open=y_close(:,21);
% CumI
CumIa_Open=y_close(:,22);
CumIc_Open=y_close(:,23);

%NEW infection (A+I) of time t
% Ia_newt=1/tau1*(Ega)
Ia_newt_total_Open=1/tau1.*(y_close(:,2));
Ic_newt_total_Open=1/tau1.*(y_close(:,7));

% New CASE (I) of time t
%I2_newt=1/tau2*(I1)
% Ia2_newt=1/tau2.*(y_total(:,4));
% Ic2_newt=1/tau2.*(y_total(:,9));
Ia2_newt_Open=[Inew_ga_0;diff(CumIa_Open)];
Ic2_newt_Open=[Inew_gc_0;diff(CumIc_Open)];
D_newt_Open=[Dnew_0;diff(CumD_Open)];

  new_infection_ga{j,k}=round(Ia_newt_total_Open);
  new_infection_gc{j,k}=round(Ic_newt_total_Open);
  
  new_I_ga(j,k)=round(mean(Ia_newt_total_Open(40:53)));
  new_I_gc(j,k)=round(mean(Ic_newt_total_Open(40:53)));
  new_I(j,k)=round(mean(Ia_newt_total_Open(40:53)))+round(mean(Ic_newt_total_Open(40:53)));
    end
end


save S2_SchoolClose_BC2_results
save('BC2_withSchoolClose_ga.mat','new_infection_ga','-v6')
save('BC2_withSchoolClose_gc.mat','new_infection_gc','-v6')

%% Plot the results
[X,Y] = meshgrid(ca2_sim,beta_g_sim);
figure(3);clf
mesh(X,Y,new_I_ga)
colorbar

% Plot two-parameters 
figure(1);clf
subplot(1,2,1)
contour(X,Y,new_I_ga,'ShowText','on')
colormap(jet)
% caxis([-40000,80000])
%colorbar
text(7.8,0.085,'*','color','r','FontSize',40)
ylabel('per contact transmission probability')
xlabel('contact rate')
title('average new adult infections two weeks after school reopening')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
subplot(1,2,2)
contour(X,Y,new_I_gc,'ShowText','on')
colormap(jet)
% caxis([-1000,2000])
%colorbar
text(7.8,0.085,'*','color','r','FontSize',40)
ylabel('per contact transmission probability')
xlabel('contact rate')
title('average new juvenile infections two weeks after school reopening')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
%print('-f4','-djpeg','-r600','./oenBorder_BI2.jpeg')

figure(4);clf
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
contour(X,Y,new_I,'ShowText','on')
colormap(jet)
% caxis([-40000,80000])
%colorbar
text(7.8,0.085,'*','color','r','FontSize',40)
ylabel('per contact transmission probability')
xlabel('contact rate')
title('Average daily new infection two weeks after school reopening')
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
print('-f4','-djpeg','-r600','./school_plot_revision/S2_SchoolClose_BC2.jpeg')
saveas(gcf,'./school_plot_revision/S2_SchoolClose_BC2.fig')
toc
sound(sin(2*pi*25*(1:4000)/100));