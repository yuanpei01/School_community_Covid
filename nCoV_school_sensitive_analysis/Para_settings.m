%nCov school opening household model
%Analyze the sensitivity of parameters
%c_aa_2 c_ac_2 c_cc_2 beta_g q_g2 q_sc 

%the parameter estimation results
par10=[8.4999e-01   6.4157e-01   9.6996e-01   2.0545e-01   2.5710e-01   8.5111e-03   4.9989e-03...
       6.5118e+00   4.8930e+00   6.5002e+00...
       7.8002e+00   5.6008e+00   8.1500e+00...
       4.3531e+00   2.8005e+00   4.2630e+00...
       5.7452e+00   3.5988e+00   6.3939e+00...
       6.9998e-03   3.2006e-02   8.5004e-02]; 
% PARAMETER BASELINE VALUES

% load fixed parameters and initial condition
load nCoV_school_param

% beta_q=par10(6);

c_ga2=par10(11);
c_ac2=par10(12);
c_cc2=par10(13);
beta_ga=par2(12);
q_g2=par10(2);
theta_i=par2(16);
a=par2(3);

q_sc=par10(3);
eta=par10(4);
attendR=par2(11);
corh=par2(20);

%PRCC_var = {'c_{aa}','c_{ac}','c_{cc}','\beta_{g}','q_{g2}','\theta_{i}','a','q_{sc}','\eta','a_{r}','nh'};% Parameter Labels 

t_end=72; % length of the simulations
time_points=[70]; % school open on sep 8

sc=[0;0;0;0;0];
y00=[data.params(1:10);sc;data.params(11:347)];
Ia_0=10;
Ic_0=4;
D_0=1;

%y_var_label={'S_p','I_p','V'};% Variables Labels