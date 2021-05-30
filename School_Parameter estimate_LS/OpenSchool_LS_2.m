%% LS estimation of nCoV-2019 Toronto outbreak from Feb 24,2020 to April 20,2020 

tic
load('LS_para_seting.mat')
%% parameters need to estimated
diary log_0418.txt
%% fminsearch 
%  options=optimset('Display','iter-detailed','MaxIter',100,'MaxFunEvals',100,'PlotFcns','optimplotfval');
%[par1, fval,exitflag,output]=fminsearch(@NCoVGTA_Household_openSchool_ss3,params_est,options)
%% fmincon
options = optimoptions('fmincon','Display','iter','Algorithm','interior-point','MaxIter',100,'TolFun',1e-4,'PlotFcns','optimplotfval');
options = optimoptions(options,'UseParallel',true);
% options = optimset('PlotFcns','optimplotfval','TolX',1e-7);

[par10,fval,exitflag]=fmincon(@NCoVGTA_Household_openSchool_ss3,params_est,[],[],[],[],lb,ub,[],options)
save('par10.mat','par10') 
toc
sound(sin(2*pi*25*(1:4000)/100));