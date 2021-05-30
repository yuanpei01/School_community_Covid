%% LS estimation of nCoV-2019 Toronto outbreak from Jul 31,2020 to Nov 23,2020 
% the model with age and household structure

clear all
clc
clear model data parama options

% par10=[mu_c q_g2 q_sc eta Gq beta_q d_1
%       c_aa_1 c_ac_1 c_cc_1... before school open
%       c_aa_2 c_ac_2 c_cc_2... after school open
%       c_aa_3 c_ac_3 c_cc_3... modified stage 2
%       c_aa_4 c_ac_4 c_cc_4 d_2] lockdown stage

% par10=[0.8495    0.6380    0.9698    0.2058    0.2568    0.0087    0.0050...    
%        6.5541    4.9017    6.4999    ...
%        7.8199    5.6051    8.1482    ...
%        4.3741    2.8074    4.2642    ...
%        5.7516    3.6024    6.3936    ...
%        0.0070    0.0322    0.0849];  %0.9968

load par10   

c_0=11.58;
tic
format short e
% load parameter and initial condition
load nCoV_school_param
%% DATA
Tor = xlsread('Toronto_0731_1123'); %function NCoVdata: construct dataset
Tor_update=xlsread('Toronto_0731_1123'); 
Inew_ga=Tor(:,4);
Inew_gc=Tor(:,3);
CumI_ga=Tor(:,6);  %Total cumulative Infection of children population Jul 31 - Dec 26
CumI_gc=Tor(:,5); 
CumI_gc_update=Tor_update(:,5);  %Total cumulative Infection of children population Jul 31 - Jan 6,21
CumI_ga_update=Tor_update(:,6); 
Inew_ga_update=Tor_update(:,4);
Inew_gc_update=Tor_update(:,3);
D=Tor(:,9);
CumD=1286+cumsum(D);
D_update=Tor_update(:,9);
CumD_update=1286+cumsum(D_update);
Num_data=length(CumI_gc);
Num_data_update=Num_data;

par1=par10;

%---------- Separate model-----------------
Num_fit=Num_data_update;% till Jan 6

% reopen stage 3, Jul 31- Sep 8
sc=[0;0;0;0;0];
y00=[data.params(1:10);sc;data.params(11:347)];
[t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[1:T1-1],y00,[],par1,par2,AC,CC); 
save('y1_till_0908.mat','y1','t1')

% school reopen Sep 8 - Oct 4
% initial state of children in the school community
q_g2=par1(2);
eta=par1(4);
Gq=par1(5);
attendR=par2(11);
y1_copy=y1;
y3=y1;
y1_temp=y1;
y3_temp=y1;
t2_g=[T1:Num_fit];
open_count=1;

for i=T1:141
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
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+6/24],y02,[],par1,par2_s1,AC,CC); 
       y1_temp=y1;
       y3=[y3(1:end-1,:);y1];
       y03=[y1_temp(end,1:10)';sc;y1_temp(end,16:352)'];
       par2_s2=[par2(1:20);0];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+18/24],y03,[],par1,par2_s2,AC,CC); 
       y3_temp=y1;
       y3=[y3(1:end-1,:);y1];
    else
        par2_s2=[par2(1:20);0];
        y03=[y3_temp(end,1:10)';sc;y3_temp(end,16:352)'];
        [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+1],y03,[],par1,par2_s2,AC,CC); 
        y3_temp=y1;
        y3=[y3(1:end-1,:);y1];
    end
 if open_count==7
     open_count=1;
 else
     open_count=open_count+1;
 end
end
y_total=[y1_copy(1:T1-1,:);y3(T1+23:24:end,:)];
y_total_2=[y1_copy(1:T1-1,:);y3(T1+4:24:end,:)]; % for school community

% y04=y1(end,:);
% par2=[par2(1:20);0];
% [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[141:1:Num_fit],y04,[],par1,par2,AC,CC);
% y_total=[y_total(1:end-1,:);y1(1:end,:)];
% y_total_2=[y_total_2(1:end-1,:);y1(1:end,:)];

% save('y_model_0106.mat','y_total','open_count','t1')
%
y_compare=[y3(2:end,1) y3(1:end-1,24) y3(2:end,2) y3(1:end-1,25) y3(2:end,3) y3(1:end-1,26) y3(2:end,4) y3(1:end-1,27) y3(2:end,5) y3(1:end-1,28)];
%CumI 
cumIga_model=y_total(:,22);
cumIgc_model=y_total(:,23);
ss1= sum((CumI_gc_update(1:Num_data_update)-cumIgc_model(1:Num_data_update)).^2);
ss2= sum((CumI_ga_update(1:Num_data_update)-cumIga_model(1:Num_data_update)).^2);
NMSE=1-(ss1+ss2)/(sum((CumI_gc_update(1:Num_data_update,1)-mean(CumI_gc_update(1:Num_data_update,1))).^2)+sum((CumI_ga_update(1:Num_data_update,1)-mean(CumI_ga_update(1:Num_data_update,1))).^2))

ss1_oct4= sum((CumI_gc_update(1:Num_data)-cumIgc_model(1:Num_data)).^2);
ss2_oct4= sum((CumI_ga_update(1:Num_data)-cumIga_model(1:Num_data)).^2);
NMSE_oct4=1-(ss1_oct4+ss2_oct4)/(sum((CumI_gc_update(1:Num_data,1)-mean(CumI_gc_update(1:Num_data,1))).^2)+sum((CumI_ga_update(1:Num_data,1)-mean(CumI_ga_update(1:Num_data,1))).^2))

% CumD
CumD_model=y_total(:,21);
%NEW CASE of time t
% Ia_newt=1/tau1*(Ega)
Ia_newt_total=1/tau1.*(y_total(:,2));
Ic_newt_total=1/tau1.*(y_total(:,7));

%I2_newt=1/tau2*(I1)
% Ia2_newt=1/tau2.*(y_total(:,4));
% Ic2_newt=1/tau2.*(y_total(:,9));
Ia2_newt=[Inew_ga(1);diff(y_total(:,22))];
Ic2_newt=[Inew_gc(1);diff(y_total(:,23))];
D_newt=[D(1);diff(y_total(:,21))];

ss1_D= sum((Inew_ga(1:Num_data)-Ia2_newt(1:Num_data)).^2);
ss2_D= sum((Inew_gc(1:Num_data)-Ic2_newt(1:Num_data)).^2);
ss3_D= sum((D(1:Num_data)-D_newt(1:Num_data)).^2);
ss3_D2= sum((CumD(1:Num_data)-CumD_model(1:Num_data)).^2);
NMSE_D=1-(ss1_D+ss2_D+ss3_D)/(sum((Inew_ga(1:Num_data,1)-mean(Inew_ga(1:Num_data,1))).^2)+sum((Inew_gc(1:Num_data,1)-mean(Inew_gc(1:Num_data,1))).^2)+sum((CumD(1:Num_data,1)-mean(CumD(1:Num_data,1))).^2))

NMSE_total=1-(ss1_oct4+ss2_oct4+ss1_D+ss2_D+ss3_D)/(sum((Inew_ga(1:Num_data,1)-mean(Inew_ga(1:Num_data,1))).^2)+sum((Inew_gc(1:Num_data,1)-mean(Inew_gc(1:Num_data,1))).^2)+sum((CumD(1:Num_data,1)-mean(CumD(1:Num_data,1))).^2)+sum((CumI_gc_update(1:Num_data,1)-mean(CumI_gc_update(1:Num_data,1))).^2)+sum((CumI_ga_update(1:Num_data,1)-mean(CumI_ga_update(1:Num_data,1))).^2))


% contact rate
% tt=[0:74];
% n_tt=length(tt);
% beta_ga=zeros(n_tt,1);
% c_ga=zeros(n_tt,1);
% % c_ga=c_0./(1+((c_0-par1(9))/par1(9))*exp(-par1(1)*(tt)))';
% for i=1:length(tt)
%   if tt(i)<=T1
%     beta_ga(i)=par1(8)./(1+((par1(8)-0.019)/0.019)*exp(-par1(7)*(tt(i))));
%     c_ga(i)=par1(13)./(1+((par1(13)-par1(9))/par1(9))*exp(-par1(1)*(tt(i))));
%   else
%     beta_ga(i)=par1(11)*par1(8)./(1+((par1(11)*par1(8)-par1(8))/par1(8))*exp(-par1(7)*(tt(i)-T1)));
%     c_ga(i)=par1(11)*par1(13)./(1+((par1(11)*par1(13)-par1(13))/par1(13))*exp(-par1(1)*(tt(i)-T1)));
%   end
% end
% %  beta_ga
% %  c_ga
% c_sc=15*exp(-par1(2).*(1-(y_total(:,11)+y_total(:,12)+y_total(:,13)+y_total(:,14)+y_total(:,15))./(y_total(:,11)+y_total(:,12)+y_total(:,13)+y_total(:,14)+y_total(:,15)+y_total(:,19))));

%% N_total
% N_total=y3(:,6)+y3(:,7)+y3(:,8)+y3(:,9)+y3(:,10)+...
%         y3(:,24)+y3(:,25)+y3(:,26)+y3(:,27)+y3(:,28)+...
%         y3(:,18)+y3(:,19);
% N_c=y3(:,6)+y3(:,7)+y3(:,8)+y3(:,9)+y3(:,10)+y3(:,19);
% N_a=y3(:,24)+y3(:,25)+y3(:,26)+y3(:,27)+y3(:,28)+y3(:,18);
% N_hc=y3(:,6)+y3(:,7)+y3(:,8)+y3(:,9)+y3(:,10);
% N_ha=y3(:,24)+y3(:,25)+y3(:,26)+y3(:,27)+y3(:,28);
save school_fit_1226

N_plot=Num_fit;
N_plot2=Num_fit;
figure(1);clf 
subplot(3,2,1)
plot(1:Num_data,CumI_ga_update(1:Num_data,1),'bo') 
hold on
plot(Num_data+1:Num_data_update,CumI_ga_update(Num_data+1:Num_data_update,1),'o','color',[0.5 0.5 0.5])
hold on
plot(1:Num_data_update,cumIga_model(1:Num_data_update,1),'-b','linewidth',2)
title('A')
ylabel('Cumulative cases of adults') 
xlim([1 Num_data])
% ylim([10000 45000])
% yticks([10000 15000 20000 25000 30000 35000 40000 45000])
% yticklabels({'10000','15000','20000','25000','30000','35000','40000','45000'})
xticks([1 30 60 90 116 149])
xticklabels({'7/31','8/29','9/28','10/28','11/23','12/26'})
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
plot(1:Num_data,CumI_gc_update(1:Num_data,1),'ro') 
hold on
plot(Num_data+1:Num_data_update,CumI_gc_update(Num_data+1:Num_data_update,1),'o','color',[0.5 0.5 0.5])
hold on
plot(1:Num_data_update,cumIgc_model(1:Num_data_update,1),'-r','linewidth',2)
% xlabel('Date') 
ylabel('Cumulative cases of children and youth ') 
xlim([1 Num_data])
xticks([1 30 60 90 116 149])
xticklabels({'7/31','8/29','9/28','10/28','11/23','12/26'})
title('C')
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
plot(1:Num_data,CumD(1:Num_data,1),'ro') 
hold on
plot(Num_data+1:Num_data_update,CumD_update(Num_data+1:Num_data_update,1),'o','color',[0.5 0.5 0.5])
hold on
plot(1:Num_data_update,CumD_model(1:Num_data_update,1),'-r','linewidth',2)
% xlabel('Date') 
ylabel('Cumulative death') 
xlim([1 Num_data])
xticks([1 30 60 90 116 149])
xticklabels({'7/31','8/29','9/28','10/28','11/23','12/26'})
title('E')
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
plot(1:Num_data,Inew_ga_update(1:Num_data,1),'bo') 
hold on
plot(Num_data+1:Num_data_update,Inew_ga_update(Num_data+1:Num_data_update,1),'o','color',[0.5 0.5 0.5])
hold on
plot(1:Num_data_update,Ia2_newt(1:Num_data_update,1),'-b','linewidth',2)
% hold on
% plot(1:Num_data_update,Ia_newt_total(1:Num_data_update,1),'-','linewidth',2)
title('B')
ylabel('Daily new cases of adults') 
xlim([1 Num_data])
% ylim([10000 45000])
% yticks([10000 15000 20000 25000 30000 35000 40000 45000])
% yticklabels({'10000','15000','20000','25000','30000','35000','40000','45000'})
xticks([1 30 60 90 116 149])
xticklabels({'7/31','8/29','9/28','10/28','11/23','12/26'})
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
plot(1:Num_data,Inew_gc_update(1:Num_data,1),'ro') 
hold on
plot(Num_data+1:Num_data_update,Inew_gc_update(Num_data+1:Num_data_update,1),'o','color',[0.5 0.5 0.5])
hold on
plot(1:Num_data_update,Ic2_newt(1:Num_data_update,1),'-r','linewidth',2)
% hold on
% plot(1:Num_data_update,Ic_newt_total(1:Num_data_update,1),'-','linewidth',2)
% xlabel('Date') 
ylabel('Daily new cases of C&Y ') 
xlim([1 Num_data])
xticks([1 30 60 90 116 149])
xticklabels({'7/31','8/29','9/28','10/28','11/23','12/26'})
title('B')
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
subplot(3,2,6)
plot(1:Num_data,D(1:Num_data,1),'ro') 
hold on
plot(Num_data+1:Num_data_update,D_update(Num_data+1:Num_data_update,1),'o','color',[0.5 0.5 0.5])
hold on
plot(1:Num_data_update,D_newt(1:Num_data_update,1),'-r','linewidth',2)
% xlabel('Date') 
ylabel('Daily new death') 
xlim([1 Num_data])
xticks([1 30 60 90 116 149])
xticklabels({'7/31','8/29','9/28','10/28','11/23','12/26'})
title('F')
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

% figure(2);clf
% subplot(5,3,1)
% plot(1:N_plot,y_total_2(1:N_plot,11),'-','linewidth',2)
% ylabel("S_{sc}")
% subplot(5,3,4)
% plot(1:N_plot,y_total_2(1:N_plot,12),'-','linewidth',2)
% ylabel("E_{sc}")
% subplot(5,3,7)
% plot(1:N_plot,y_total_2(1:N_plot,13),'-','linewidth',2)
% ylabel("A_{sc}")
% subplot(5,3,10)
% plot(1:N_plot,y_total_2(1:N_plot,14),'-','linewidth',2)
% ylabel("I_{sc1}")
% subplot(5,3,13)
% plot(1:N_plot,y_total_2(1:N_plot,15),'-','linewidth',2)
% ylabel("I_{sc2}")
% subplot(5,3,2)
% plot(1:N_plot,y_total(1:N_plot,6),'-','linewidth',2)
% ylabel("S_{gc}")
% subplot(5,3,5)
% plot(1:N_plot,y_total(1:N_plot,7),'-','linewidth',2)
% ylabel("E_{gc}")
% subplot(5,3,8)
% plot(1:N_plot,y_total(1:N_plot,8),'-','linewidth',2)
% ylabel("A_{gc}")
% subplot(5,3,11)
% plot(1:N_plot,y_total(1:N_plot,9),'-','linewidth',2)
% ylabel("I_{gc1}")
% subplot(5,3,14)
% plot(1:N_plot,y_total(1:N_plot,10),'-','linewidth',2)
% ylabel("I_{gc2}")
% subplot(5,3,3)
% plot(1:N_plot,y_total(1:N_plot,1),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y_total(1:N_plot,24),'-','linewidth',2)
% % legend('S_{ga}','S_{ha}')
% ylabel("S_{ga}")
% subplot(5,3,6)
% plot(1:N_plot,y_total(1:N_plot,2),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y_total(1:N_plot,25),'-','linewidth',2)
% % legend('E_{ga}','E_{ha}')
% ylabel("E_{ga}")
% subplot(5,3,9)
% plot(1:N_plot,y_total(1:N_plot,3),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y_total(1:N_plot,26),'-','linewidth',2)
% % legend('A_{ga}','A_{ha}')
% ylabel("A_{ga}")
% subplot(5,3,12)
% plot(1:N_plot,y_total(1:N_plot,4),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y_total(1:N_plot,27),'-','linewidth',2)
% % legend('I_{ga1}','I_{ha1}')
% ylabel("I_{ga1}")
% subplot(5,3,15)
% plot(1:N_plot,y_total(1:N_plot,5),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y_total(1:N_plot,28),'-','linewidth',2)
% % legend('I_{ga2}','I_{ha2}')
% ylabel("I_{ga2}")
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% 
% % figure(3);clf
% % subplot(3,1,1)
% % plot(1:N_plot,c_ga(1:N_plot,1),'-','linewidth',2)
% % ylabel("contact rate among adult")
% % set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% % set(get(gca,'YLabel'),'FontSize',14);
% % set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% % %set(get(gca,'Children'),'MarkerSize',10);
% % set(gca,'FontSize',13,'linewidth',1.5)
% % set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
% %     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
% %     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
% %     'LineWidth', 1)
% % subplot(3,1,2)
% % plot(1:N_plot,c_sc(1:N_plot,1),'-','linewidth',2)
% % ylabel("contact rate among juvenile in the school")
% % set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% % set(get(gca,'YLabel'),'FontSize',14);
% % set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% % %set(get(gca,'Children'),'MarkerSize',10);
% % set(gca,'FontSize',13,'linewidth',1.5)
% % set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
% %     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
% %     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
% %     'LineWidth', 1)
% % subplot(3,1,3)
% % plot(1:N_plot,beta_ga(1:N_plot,1),'-','linewidth',2)
% % ylabel("\beta_{ga}")
% % set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% % set(get(gca,'YLabel'),'FontSize',14);
% % set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% % %set(get(gca,'Children'),'MarkerSize',10);
% % set(gca,'FontSize',13,'linewidth',1.5)
% % set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
% %     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
% %     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
% %     'LineWidth', 1)
% 
% figure(4);clf
% subplot(2,2,1)
% plot(1:N_plot,Ia_newt_total(1:N_plot,1),'-','linewidth',2)
% ylabel("daily new adult cases")
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% subplot(2,2,2)
% plot(1:N_plot,Ic_newt_total(1:N_plot,1),'-','linewidth',2)
% ylabel("daily new juvenile cases")
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% subplot(2,2,3)
% plot(1:Num_data,Inew_ga,'bo') 
% hold on
% plot(1:N_plot,Ia2_newt(1:N_plot,1),'-','linewidth',2)
% ylabel("daily new symptomatic adult cases")
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% subplot(2,2,4)
% plot(1:Num_data,Inew_gc,'bo') 
% hold on
% plot(1:N_plot,Ic2_newt(1:N_plot,1),'-','linewidth',2)
% ylabel("daily new symptomatic juvenile cases")
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% N_plot=length(y3(:,1));
% figure(5);clf
% plot(1:N_plot,N_total(1:N_plot,1),'-','linewidth',2)
% hold on
% plot(1:N_plot,N_a(1:N_plot,1),'-','linewidth',2)
% hold on
% plot(1:N_plot,N_c(1:N_plot,1),'-','linewidth',2)
% hold on
% plot(1:N_plot,N_ha(1:N_plot,1),'-','linewidth',2)
% hold on
% plot(1:N_plot,N_hc(1:N_plot,1),'-','linewidth',2)
% hold on
% plot(1:N_plot,y3(1:N_plot,18),'-','linewidth',2)
% hold on
% plot(1:N_plot,y3(1:N_plot,19),'-','linewidth',2)
% legend('N','N_a','N_c','N_{ha}','N_{hc}','S_{qa}','S_{qc}')
% set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
% set(get(gca,'YLabel'),'FontSize',14);
% set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
% %set(get(gca,'Children'),'MarkerSize',10);
% set(gca,'FontSize',13,'linewidth',1.5)
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
% 
% figure(6);clf
% subplot(5,3,1)
% plot(1:N_plot,y3(1:N_plot,11),'-','linewidth',2)
% ylabel("S_{sc}")
% subplot(5,3,4)
% plot(1:N_plot,y3(1:N_plot,12),'-','linewidth',2)
% ylabel("E_{sc}")
% subplot(5,3,7)
% plot(1:N_plot,y3(1:N_plot,13),'-','linewidth',2)
% ylabel("A_{sc}")
% subplot(5,3,10)
% plot(1:N_plot,y3(1:N_plot,14),'-','linewidth',2)
% ylabel("I_{sc1}")
% subplot(5,3,13)
% plot(1:N_plot,y3(1:N_plot,15),'-','linewidth',2)
% ylabel("I_{sc2}")
% subplot(5,3,2)
% plot(1:N_plot,y3(1:N_plot,6),'-','linewidth',2)
% ylabel("S_{gc}")
% subplot(5,3,5)
% plot(1:N_plot,y3(1:N_plot,7),'-','linewidth',2)
% ylabel("E_{gc}")
% subplot(5,3,8)
% plot(1:N_plot,y3(1:N_plot,8),'-','linewidth',2)
% ylabel("A_{gc}")
% subplot(5,3,11)
% plot(1:N_plot,y3(1:N_plot,9),'-','linewidth',2)
% ylabel("I_{gc1}")
% subplot(5,3,14)
% plot(1:N_plot,y3(1:N_plot,10),'-','linewidth',2)
% ylabel("I_{gc2}")
% subplot(5,3,3)
% plot(1:N_plot,y3(1:N_plot,1),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y3(1:N_plot,24),'-','linewidth',2)
% % legend('S_{ga}','S_{ha}')
% ylabel("S_{ga}")
% subplot(5,3,6)
% plot(1:N_plot,y3(1:N_plot,2),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y3(1:N_plot,25),'-','linewidth',2)
% % legend('E_{ga}','E_{ha}')
% ylabel("E_{ga}")
% subplot(5,3,9)
% plot(1:N_plot,y3(1:N_plot,3),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y3(1:N_plot,26),'-','linewidth',2)
% % legend('A_{ga}','A_{ha}')
% ylabel("A_{ga}")
% subplot(5,3,12)
% plot(2:N_plot,y3(2:N_plot,4),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y3(1:N_plot,27),'-','linewidth',2)
% % legend('I_{ga1}','I_{ha1}')
% ylabel("I_{ga1}")
% subplot(5,3,15)
% plot(1:N_plot,y3(1:N_plot,5),'-','linewidth',2)
% % hold on
% % plot(1:N_plot,y3(1:N_plot,28),'-','linewidth',2)
% % legend('I_{ga2}','I_{ha2}')
% ylabel("I_{ga2}")
% set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
%     'XMinorTick', 'on', 'YMinorTick', 'on', 'YGrid', 'off', ...
%     'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
%     'LineWidth', 1)
toc
sound(sin(2*pi*25*(1:4000)/100));

% tt=[0:66];
% % ttt=11.58./(1+((11.58-5)/5)*exp(-0.1*(tt)));
% ttt=0.024./(1+((0.024-0.019)/0.019)*exp(-0.08*(tt)));
% figure(7);
% plot(tt,ttt)