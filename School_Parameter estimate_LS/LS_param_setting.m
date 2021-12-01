%% LS estimation of nCoV-2019 Toronto outbreak from Feb 24,2020 to April 20,2020 
% the update model with adherance rate 
% Household Quarantine
clear all
clc
clear model data parama options

format short e
Tor = xlsread('Toronto_0731_1123'); %function NCoVdata: construct dataset
Inew_ga=Tor(:,4);
Inew_gc=Tor(:,3);
CumI_ga=Tor(:,6);  %Total cumulative Infection of children population Jul 31 - Sep 28
CumI_gc=Tor(:,5); 
D=Tor(:,9);
CumD=1286+cumsum(D);
% CumR=Tor(:,8);
Num_data=length(CumI_gc);
tic
load nCoV_school_param
%% linked initial states and parameters 
M1=[Sga_0;Ega_0;Aga_0;Iga1_0;Iga2_0;
             Sgc_0;Egc_0;Agc_0;Igc1_0;Igc2_0;
             H_0;W_0;Sqa_0;Sqc_0;R_0;D_0;cumIga_0;cumIgc_0;
             Sga_0;Ega_0;Aga_0;Iga1_0;Iga2_0;P_0;
             tau1;tau2;a;gamma_a;gamma_m;gamma;sigma;p_c;q_h;Nh;attendR;
             beta_ga;beta_q;theta_ha;theta_hc;theta_i;T1;muT;c_0;corh;schoolOpen]; 

M2=AC;
M3=CC;
%% PARAMS
% Refine the first guess for the parameters with |fminseacrh| and
% calculate residual variance as an estimate of the model error variance.

% set the initial values and intervals of unknown parameters
% par10=[mu_c q_g2 q_sc eta Gq beta_q d_1
%       c_aa_1 c_ac_1 c_cc_1... before school open
%       c_aa_2 c_ac_2 c_cc_2... after school open
%       c_aa_3 c_ac_3 c_cc_3... modified stage 2
%       c_aa_4 c_ac_4 c_cc_4... lockdown stage 
%       d_2 d_3 d_4] death rate in different stage
params_est=[8.4999e-01   6.4157e-01   9.6996e-01   2.0545e-01   2.5710e-01   8.5111e-03   4.9989e-03...
       6.6118e+00   4.9930e+00   6.5002e+00...
       7.8002e+00   5.6008e+00   8.1500e+00...
       4.4331e+00   2.9005e+00   4.2630e+00...
       5.5552e+00   3.4788e+00   6.3939e+00...
       6.9998e-03   3.2006e-02   8.5004e-02];%0.997
     lb=[0.5  0.5    0.5   0.1   0.1  0.005 0.002  1  1  1  1  1  1  1  1  1  1  1  1  0.002 0.002 0.002];
     ub=[1    0.85   1  0.5   0.5  0.02  0.02   10 10 10 10 10 10 10 10 10 10 10 10  0.1 0.1 0.1];
save LS_para_seting
save('LS_data.mat','M1','M2','M3','Num_data', 'Inew_ga', 'Inew_gc', 'D', 'CumD','CumI_ga','CumI_gc')
     