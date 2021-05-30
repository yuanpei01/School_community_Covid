 % The parameter setting
 % Fixed parameters
 % Initial conditions
%% fixed parameters
Np=2956024;%GTA:6.197e+6;
tau1=4;
tau2=3;
a=0.953; %Wuhan
gamma_a=0.07;% get from Wuhan case
gamma_m=1/14;
gamma=0.0357; 
sigma=0.0152;% same with Wuhan case
p_c=0.3839; % proportion of household with kids
q_h=0.389; % proportion of household staying at home
attendR=0.6834;
Nh=1112930;
beta_ga=0.041; %from ref Seyed 2020
beta_q=1.5030e-02; % From SAHP model
c_0=11.58;
theta_ha=0.0152;
theta_hc=8e-05;
theta_i=3.9978e-02;
T1=40; % Sep 8
T2=64; % Oct 2
T3=94; % Nov 1
muT=7;
n=3;% average hosehold population.
schoolOpen=0;
corh=15;
%% Initial variable values 
% intial state of adults
Sqa_0=964716;
Sga_0=1500429;
Ega_0=93;
Aga_0=2;
Iga1_0=39;
Iga2_0=217;
% initial state of children
Sqc_0=185177;
Sgc_0=289819;
Egc_0=21;
Agc_0=0;
Igc1_0=10;
Igc2_0=43;
% others
H_0=99;
W_0=9;
R_0=14063;
D_0=1287;
cumIga_0=14191;
cumIgc_0=996;
Ha_0=99;
Wa_0=9;
Ra_0=13100;
Hc_0=0;
Wc_0=0;
Rc_0=963;
N_H0=757637;
N_Hc0=466780;
% compute all the combination of different class, 324
Chilren=zeros(9,8);
class=[1 2 3 4 5 6 7 8];
count=1;
for i=1:8
          sample_class=[class(i)];
          class1=length(find(sample_class==class(1)));
          class2=length(find(sample_class==class(2)));
          class3=length(find(sample_class==class(3)));
          class4=length(find(sample_class==class(4)));
          class5=length(find(sample_class==class(5)));
          class6=length(find(sample_class==class(6)));
          class7=length(find(sample_class==class(7)));
          class8=length(find(sample_class==class(8)));
          Chilren(count,:)=[class1 class2 class3 class4 class5 class6 class7 class8];
          count=count+1;
end
CC=unique(Chilren,'rows');
c=zeros(9,1);
count=1;
for i=1:9
    c_d=length(find(CC(i,:)));
    if c_d > 0
        c(count)=find(CC(i,:));
    else
        c(count)=0;
    end
    count=count+1;
end
AC=zeros(324,9);
count=1;
for i=1:8
    for j=1:8 
        for k=1:9
          sample_class=[class(i) class(j)];
          class1=length(find(sample_class==class(1)));
          class2=length(find(sample_class==class(2)));
          class3=length(find(sample_class==class(3)));
          class4=length(find(sample_class==class(4)));
          class5=length(find(sample_class==class(5)));
          class6=length(find(sample_class==class(6)));
          class7=length(find(sample_class==class(7)));
          class8=length(find(sample_class==class(8)));
          AC(count,:)=[class1 class2 class3 class4 class5 class6 class7 class8 k];
          count=count+1;
        end
    end
end
AC=unique(AC,'rows');

% initial state of household
P_0=zeros(324,1);
Q=[Sga_0 Ega_0 Aga_0 Iga1_0 Iga2_0 Ha_0 Wa_0 Ra_0];
Qc=[N_Hc0 Rc_0 Wc_0 Hc_0 Igc2_0 Igc1_0 Agc_0 Egc_0 Sgc_0];
NQ=Sga_0+Ega_0+Aga_0+Iga1_0+Iga2_0+Ha_0+Wa_0+Ra_0;
F_sum=0;
for count=1:324
    nonzero=sum(AC(count,1:8)~=0,2);
    index_c=AC(count,9);
        if nonzero==1
            i=find(AC(count,1:8));
            if Q(i)>2
             F=Q(i)*(Q(i)-1)./prod(NQ-1:NQ)*(Qc(index_c)/N_H0);
            else
             F=0;
            end
        elseif nonzero==2
            index=find(AC(count,1:8));
            i=index(1);
            j=index(2);
               if Q(i)>0 && Q(j)>0
                  F=Q(i)*Q(j)./prod(NQ-1:NQ)*(Qc(index_c)/N_H0);
                else
                  F=0;
               end
        end
    
    F_new=F;
    F_sum=F_sum+F_new;
    P_0(count,1)=round(N_H0*F);
end    
% initial state of children in the school community
%% linked initial states and parameters 
data.params=[Sga_0;Ega_0;Aga_0;Iga1_0;Iga2_0;
             Sgc_0;Egc_0;Agc_0;Igc1_0;Igc2_0;
             H_0;W_0;Sqa_0;Sqc_0;R_0;D_0;cumIga_0;cumIgc_0;
             Sga_0;Ega_0;Aga_0;Iga1_0;Iga2_0;P_0;
             tau1;tau2;a;gamma_a;gamma_m;gamma;sigma;p_c;q_h;Nh;attendR;
             beta_ga;beta_q;theta_ha;theta_hc;theta_i;T1;muT;c_0;corh;schoolOpen]; 

par2=data.params(348:end);

save nCoV_school_param