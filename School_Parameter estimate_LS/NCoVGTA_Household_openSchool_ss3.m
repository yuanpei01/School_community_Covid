function ss = NCoVGTA_Household_openSchool_ss3(pars)
% SSDM  sum-of-squares for the difference of data and model
% INPUT
    %data -a structure containing data.ydata and data.par2;
           % data.par2 -known parameters and intial states;
    %pars -all to be estimated parameters and initial states of model "NCoVGTA_1". 
% OUTPUT
    %ss - sum of squares for the difference of varable x(4) between data and model 
clear t1 y1 y3 y_total

% %% the real data (observations)
% CumI = data.ydata(:,2);
% Num_data=length(CumI);
load('LS_data.mat')
% initial state
%fixed parameters
par_f = M1(348:end);  
AC=M2;
CC=M3;
T1=40;
%% Fit model
%options=odeset('RelTol',1e-3,'AbsTol',1e-3);
%tic
% %figure(1);
% hold on
% plot(1:Num_data,I_model)
sc=[0;0;0;0;0];
y00=[M1(1:10);sc;M1(11:347)];
[t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[1:T1-1],y00,[],pars,par_f,AC,CC); 
% school reopen Sep 8 - Oct 4
% initial state of children in the school community
q_g2=pars(2);
eta=pars(4);
Gq=pars(5);
attendR=par_f(11);
muT=M1(end-2);
corh=15;

y1_copy=y1;
y3=y1;
y1_temp=y1;
y3_temp=y1;
% t2_g=[T1:Num_fit];
open_count=1;

for i=T1:Num_data
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
       par2_s1=[par_f(1:20);1];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+6/24],y02,[],pars,par2_s1,AC,CC); 
       y1_temp=y1;
       y3=[y3(1:end-1,:);y1];
       y03=[y1_temp(end,1:10)';sc;y1_temp(end,16:352)'];
       par2_s2=[par_f(1:20);0];
       [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+18/24],y03,[],pars,par2_s2,AC,CC); 
       y3_temp=y1;
       y3=[y3(1:end-1,:);y1];
    else
        par2_s2=[par_f(1:20);0];
        y03=[y3_temp(end,1:10)';sc;y3_temp(end,16:352)'];
        [t1,y1] = ode45(@NCoVGTA_Household_openSchool_noWork_0108,[t1(end):1/24:t1(end)+1],y03,[],pars,par2_s2,AC,CC); 
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
%CumI 
cumIga_model=y_total(:,22);
cumIgc_model=y_total(:,23);
cumD_model=y_total(:,21);
Ia_newt=[Inew_ga(1);diff(y_total(:,22))];
Ic_newt=[Inew_gc(1);diff(y_total(:,23))];
% D_newt=[D(1);diff(y_total(:,21))];

%toc
ss1= sum((Inew_ga(1:Num_data)-Ia_newt(1:Num_data)).^2)/sum((Inew_ga(1:Num_data,1)-mean(Inew_ga(1:Num_data,1))).^2);
ss2= sum((Inew_gc(1:Num_data)-Ic_newt(1:Num_data)).^2)/sum((Inew_gc(1:Num_data,1)-mean(Inew_gc(1:Num_data,1))).^2);
ss3= sum((CumD(1:Num_data)-cumD_model(1:Num_data)).^2)/sum((CumD(1:Num_data,1)-mean(CumD(1:Num_data,1))).^2);
ss4= sum((CumI_ga(1:Num_data)-cumIga_model(1:Num_data)).^2)/sum((CumI_ga(1:Num_data,1)-mean(CumI_ga(1:Num_data,1))).^2);
ss5= sum((CumI_gc(1:Num_data)-cumIgc_model(1:Num_data)).^2)/sum((CumI_gc(1:Num_data,1)-mean(CumI_gc(1:Num_data,1))).^2);
ss=ss1+ss2+ss3+ss4+ss5;







