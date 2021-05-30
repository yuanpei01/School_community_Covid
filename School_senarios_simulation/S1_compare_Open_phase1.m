%% comparision of differnt open control measures
% the model with age and household structure

clear all
clc
clear model data parama options

tic
format short e

load nCoV_school_param

load par10
 
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
%% after school open
% School close
par1_Open_phase1=[par10(1:6) sim_phase1];

% school reopen Sep 8 - Oct 4
% initial state of children in the school community
q_g2=par10(2);
eta=par10(4);
Gq=par10(5);
attendR=par2(11);
y1_copy=y1;
y3=y1;
y1_temp=y1;
y3_temp=y1;
t2_g=[T1:Num_fit];
open_count=1;

for i=T1:Num_fit
    if open_count<=5
       g_cdf=expcdf(i-T1+1,muT);
       cum_ga=attendR*g_cdf;
       Ssc_temp=y1_temp(end,11);
       Esc_temp=y1_temp(end,12);
       Asc_temp=y1_temp(end,13);
       Isc1_temp=y1_temp(end,14);
       Nsc_temp=Ssc_temp+Esc_temp+Asc_temp+Isc1_temp;
       Isc2_temp=y1_temp(end,15);
       if Nsc_temp==0
           Ssc_0=cum_ga*y3_temp(end,6);
           Esc_0=cum_ga*y3_temp(end,7);
           Asc_0=cum_ga*(1-eta)*y3_temp(end,8);
           Isc1_0=cum_ga*(1-eta)*y3_temp(end,9);
       else
           Ssc_0=cum_ga*y3_temp(end,6)-corh*Ssc_temp/Nsc_temp*Isc2_temp;
           Esc_0=cum_ga*y3_temp(end,7)-corh*Esc_temp/Nsc_temp*Isc2_temp;
           Asc_0=cum_ga*(1-eta)*y3_temp(end,8)-corh*Asc_temp/Nsc_temp*Isc2_temp;
           Isc1_0=cum_ga*(1-eta)*y3_temp(end,9)-corh*Isc1_temp/Nsc_temp*Isc2_temp;
       end
      
       y02=[y3_temp(end,1:10)';Ssc_0;Esc_0;Asc_0;Isc1_0;0;y3_temp(end,16:352)'];
       par2_s1=[par2(1:20);1];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_sim,[t1(end):1/24:t1(end)+6/24],y02,[],par1_Open_phase1,par2_s1,AC,CC); 
       y1_temp=y1;
       y3=[y3(1:end-1,:);y1];
       y03=[y1_temp(end,1:10)';sc;y1_temp(end,16:352)'];
       par2_s2=[par2(1:20);0];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_sim,[t1(end):1/24:t1(end)+18/24],y03,[],par1_Open_phase1,par2_s2,AC,CC); 
       y3_temp=y1;
       y3=[y3(1:end-1,:);y1];
    else
        par2_s2=[par2(1:20);0];
        y03=[y3_temp(end,1:10)';sc;y3_temp(end,16:352)'];
        [t1,y1] = ode45(@NCoVGTA_Household_openSchool_sim,[t1(end):1/24:t1(end)+1],y03,[],par1_Open_phase1,par2_s2,AC,CC); 
        y3_temp=y1;
        y3=[y3(1:end-1,:);y1];
    end
 if open_count==7
     open_count=1;
 else
     open_count=open_count+1;
 end
end
y_Open_phase1=[y1_copy(1:T1-1,:);y3(T1+23:24:end,:)];
y2_Open_phase1=[y1_copy(1:T1-1,:);y3(T1+4:24:end,:)]; % for school community

% CumD
CumD_Open_phase1=y_Open_phase1(:,21);
% CumI
CumIa_Open_phase1=y_Open_phase1(:,22);
CumIc_Open_phase1=y_Open_phase1(:,23);

%NEW infection (A+I) of time t
% Ia_newt=1/tau1*(Ega)
Ia_newt_total_Open_phase1=1/tau1.*(y_Open_phase1(:,2));
Ic_newt_total_Open_phase1=1/tau1.*(y_Open_phase1(:,7));

% New CASE (I) of time t
%I2_newt=1/tau2*(I1)
% Ia2_newt=1/tau2.*(y_total(:,4));
% Ic2_newt=1/tau2.*(y_total(:,9));
Ia2_newt_Open_phase1=[Inew_ga_0;diff(CumIa_Open_phase1)];
Ic2_newt_Open_phase1=[Inew_gc_0;diff(CumIc_Open_phase1)];
D_newt_Open_phase1=[Dnew_0;diff(CumD_Open_phase1)];

% new case in School
Isc_Open_phase1=y2_Open_phase1(:,15);

save S1_compare_Open_phase1

N_plot=Num_fit;
N_plot2=Num_fit;
figure(2);clf 
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,2,1)
plot(1:N_plot,Ia_newt_total_Open_phase1,'-','linewidth',2) 
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
plot(1:N_plot,Ic_newt_total_Open_phase1,'-','linewidth',2) 
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
plot(1:N_plot,D_newt_Open_phase1,'-','linewidth',2) 
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
print('-f2','-djpeg','-r600','./school_plot_revision/S1_compare_Open_phase1.jpeg')
saveas(gcf,'./school_plot_revision/S1_compare_Open_phase1.fig')
toc
sound(sin(2*pi*25*(1:4000)/100));

% tt=[0:66];
% % ttt=11.58./(1+((11.58-5)/5)*exp(-0.1*(tt)));
% ttt=0.024./(1+((0.024-0.019)/0.019)*exp(-0.08*(tt)));
% figure(7);
% plot(tt,ttt)