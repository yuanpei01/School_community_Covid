% The parameter sensitivity analysis of school opening model
% For the output: new case in the shool
% Pei Yuan 
% Date: 2021.03.21

clear all
close all;

runs=2000; % Sample size N
Para_settings;% LHS matrix
PRCC_var = {'q_{sc}','\eta','a_{r}','nh'};
SA_var=[q_sc eta attendR corh];
SA_var_min=0.8*SA_var;
SA_var_max=1.2*SA_var;
q_sc_LHS=LHS_Call(0.7, q_sc, 1, 0,runs,'unif'); 
eta_LHS=LHS_Call(SA_var_min(2), eta, SA_var_max(2), 0,runs,'unif'); 
attendR_LHS=LHS_Call(SA_var_min(3), attendR,  SA_var_max(3), 0,runs,'unif'); 
corh_LHS=LHS_Call(SA_var_min(4), corh,  SA_var_max(4), 0,runs,'unif'); 
tic
% LHS matrix and para. labels
LHSmatrix=[ q_sc_LHS eta_LHS attendR_LHS corh_LHS];

Ia_lhs=zeros(t_end,runs);
Ic_lhs=zeros(t_end,runs);
Isc_lhs=zeros(t_end,runs);
D_lhs=zeros(t_end,runs);

cumIa_lhs=zeros(t_end,runs);
cumIc_lhs=zeros(t_end,runs);
cumD_lhs=zeros(t_end,runs);


load y1_till_0908.mat
y1_00=y1;
t1_00=t1;

parfor y=1:runs
    par1_LHS=[par10(1:2) LHSmatrix(y,1:2) par10(5:22)];
% school reopen Sep 8 
% initial state of children in the school community
y1=y1_00;
t1=t1_00;
q_g2=par10(2);
eta=LHSmatrix(y,2);
Gq=par10(5);
attendR=LHSmatrix(y,3);
y1_copy=y1;
y3=y1;
y1_temp=y1;
y3_temp=y1;
open_count=1;

for i=T1:t_end
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
       par2_s1=[par2(1:10);LHSmatrix(y,3);par2(12:19);LHSmatrix(y,4);1];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+6/24],y02,[],par1_LHS,par2_s1,AC,CC); 
       y1_temp=y1;
       y3=[y3(1:end-1,:);y1];
       y03=[y1_temp(end,1:10)';sc;y1_temp(end,16:352)'];
       par2_s2=[par2(1:10);LHSmatrix(y,3);par2(12:19);LHSmatrix(y,4);0];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+18/24],y03,[],par1_LHS,par2_s2,AC,CC); 
       y3_temp=y1;
       y3=[y3(1:end-1,:);y1];
    else
        par2_s2=[par2(1:10);LHSmatrix(y,3);par2(12:19);LHSmatrix(y,4);0];
        y03=[y3_temp(end,1:10)';sc;y3_temp(end,16:352)'];
        [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+1],y03,[],par1_LHS,par2_s2,AC,CC); 
        y3_temp=y1;
        y3=[y3(1:end-1,:);y1];
    end
 if open_count==7
     open_count=1;
 else
     open_count=open_count+1;
 end
end

y_total=[y1_copy(1:T1-1,:);y3(T1+22:24:end,:)];
y_total_2=[y1_copy(1:T1-1,:);y3(T1+4:24:end,:)];  
 cumIa=y_total(:,22);
 cumIc=y_total(:,23);
 cumD=y_total(:,21);
 Ia_new=[Ia_0;diff(cumIa)];
 Ic_new=[Ic_0;diff(cumIc)];
 D_new=[D_0;diff(cumD)];
 
%  Ia_lhs(:,y)=(Ia_new);
%  Ic_lhs(:,y)=(Ic_new);
%  D_lhs(:,y)=(D_new);
%  4
%  Isc_lhs(:,y)=(y_total_2(:,15));
%  5
 yy=[Ia_new Ic_new D_new];
    t=[1:t_end]';
    A=[t y_total];
%     A(:,1)
%      size(A)
    if size(A,1)>=max(time_points+1)
    cumIa_lhs(:,y)=A(time_points+1,23);
    cumIc_lhs(:,y)=A(time_points+1,24);
    cumD_lhs(:,y)=A(time_points+1,22);
    end 
    C=[t yy];
    if size(C,1)>=max(time_points+1)
    Ia_lhs(:,y)=C(time_points+1,2);
    Ic_lhs(:,y)=C(time_points+1,3);
    D_lhs(:,y)=C(time_points+1,4);
    end 
    B=[t y_total_2];
%     size(B)
    if size(B,1)>=max(time_points+1)
    Isc_lhs(:,y)=B(time_points+1,16);
    end 
end

alpha = 0.05;
save Household_sensitivity_results_sc_2000

% load Household_sensitivity_results_2000

% %%PRCC for Isc%%
[prcc sign sign_label]=PRCCM_sc(LHSmatrix,Isc_lhs,1:length(time_points),PRCC_var,alpha);
toc

% print('-f3','-djpeg','-r600','./School_Sensitivity_school.jpeg')