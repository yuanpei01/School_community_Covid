function xdot = NCoVGTA_Household_openSchool_noWork_0108(t,x,par1,par2,AC,CC)
% Adult population
Sga=x(1);Ega=x(2);Aga=x(3);Iga1=x(4);Iga2=x(5);
% Children population
Sgc=x(6);Egc=x(7);Agc=x(8);Igc1=x(9);Igc2=x(10);
% School community
Ssc=x(11);Esc=x(12);Asc=x(13);Isc1=x(14);Isc2=x(15);
% Total population 
H=x(16);W=x(17);
% population stay at home
Sqa=x(18);
Sqc=x(19);
%For calculation
R=x(20);
D=x(21);
Iga=x(22);
Igc=x(23);

%For adult population in the household
Sha=x(24); Eha=x(25);Aha=x(26);Iha1=x(27);Iha2=x(28);



% Z unknown parameters; par1 


mu_c=par1(1);
q_g2=par1(2);
q_sc=par1(3);
eta=par1(4);
Gq=par1(5);
beta_q=par1(6);
d_1=par1(7);
c_ga1=par1(8);
c_ac1=par1(9);
c_cc1=par1(10);
c_ga2=par1(11);
c_ac2=par1(12);
c_cc2=par1(13);
c_ga3=par1(14);
c_ac3=par1(15);
c_cc3=par1(16);
c_ga4=par1(17);
c_ac4=par1(18);
c_cc4=par1(19);
d_2=par1(20);
d_3=par1(21);
d_4=par1(22);
% Z known parameters; par2
tau1=par2(1);
tau2=par2(2);
a=par2(3);
gamma_a=par2(4);
gamma_m=par2(5);
gamma=par2(6);
sigma=par2(7);
p_c=par2(8);
q_h=par2(9);
Nh=par2(10);
attendR=par2(11);
beta_ga=par2(12);
% beta_q=par2(13);
theta_ha=par2(14);
theta_hc=par2(15);
theta_i=par2(16);
T1=par2(17);
muT=par2(18);
c_0=par2(19);
corh=par2(20);
schoolOpen=par2(21);

if t<T1
    c_ga=c_ga1;
    c_ac=c_ac1;
    c_cc=c_cc1;
    d=d_1;
  elseif t<64
    c_ga=c_ga2;
    c_ac=c_ac2;
    c_cc=c_cc2;
    d=d_2;
    elseif t<94
    c_ga=c_ga3;
    c_ac=c_ac3;
    c_cc=c_cc3;
    d=d_3;
else
    c_ga=c_ga4;
    c_ac=c_ac4;
    c_cc=c_cc4;
    d=d_4;
end

% beta_ga=beta_ga_max./(1+((beta_ga_max-0.019)/0.019)*exp(-beta_ga_k*(t)));
% if t<T1
%     beta_ga=beta_ga_max./(1+((beta_ga_max-0.019)/0.019)*exp(-beta_ga_k*(t)));
% else
%     beta_ga=1.2*beta_ga_max./(1+((1.2*beta_ga_max-0.019)/0.019)*exp(-beta_ga_k*(t)));
% end
beta_sc=0.5*beta_ga;

g=exppdf(t-T1,muT);
gq=(Gq*p_c*q_h*Nh*g)/Sqc;

c_sc=corh*attendR*exp(-mu_c*(1-(Ssc+Esc+Asc+Isc1+Isc2)/(Sgc+Egc+Agc+Igc1+Igc2)));
% c_sc=corh*exp(-mu_c*(1-(Ssc+Esc+Asc+Isc1+Isc2)/(Sgc+Egc+Agc+Igc1+Igc2+Sqc)));
% c_ga=6;
% c_ga=c_0./(1+((c_0-ca_min)/ca_min)*exp(-mu_a*(t)));
% for i=1:120
%     if PP(i,1)==2&&PP(i,5)==1
%     index=i
%     end
% end

% name the variable
for i=1:324    
 eval(['P',num2str(AC(i,1)),num2str(AC(i,2)),num2str(AC(i,3)),num2str(AC(i,4)),num2str(AC(i,5)),num2str(AC(i,6)),num2str(AC(i,7)),num2str(AC(i,8)),num2str(AC(i,9)),'=','x(i+28)',';']);
end
% compute Pdot
Pdot=zeros(324,1);
Sgc_dot=0;
Egc_dot=0;
Agc_dot=0;
Igc1_dot=0;
Igc2_dot=0;

Sha_dot=0;
Eha_dot=0;
Aha_dot=0;
Iha1_dot=0;
Iha2_dot=0;

Ega_temp=0;
Egc_temp=0;

Sha_temp1=0;
Sha_temp2=0;

for count=1:324
    ii=AC(count,1);
    jj=AC(count,2);
    kk=AC(count,3);
    ll=AC(count,4);
    mm=AC(count,5);
    xx=AC(count,6);
    yy=AC(count,7);
    zz=AC(count,8);
    ch=AC(count,9);
        P_ijklmxyzc=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch)]);
    if jj>=1 && ii<=1
        P_i1j_1klmxyzc=eval(['P',num2str(ii+1),num2str(jj-1),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch)]);
        else
        P_i1j_1klmxyzc=0;
    end
     
    if kk>=1 && jj<=1
        P_ij1k_1lmxyzc=eval(['P',num2str(ii),num2str(jj+1),num2str(kk-1),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch)]);
        else
        P_ij1k_1lmxyzc=0;
    end
    
    if ll>=1 && jj<=1
        P_ij1kl_1mxyzc=eval(['P',num2str(ii),num2str(jj+1),num2str(kk),num2str(ll-1),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch)]);
        else
        P_ij1kl_1mxyzc=0;
    end
    
    if mm>=1 && ll<=1
        P_ijkl1m_1xyzc=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll+1),num2str(mm-1),num2str(xx),num2str(yy),num2str(zz),num2str(ch)]);
        else
        P_ijkl1m_1xyzc=0;
    end
    
    if xx>=1 && mm<=1
        P_ijklm1x_1yzc=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm+1),num2str(xx-1),num2str(yy),num2str(zz),num2str(ch)]);
        else
        P_ijklm1x_1yzc=0;
    end
    
    if yy>=1 && mm<=1
        P_ijklm1xy_1zc=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm+1),num2str(xx),num2str(yy-1),num2str(zz),num2str(ch)]);
        else
        P_ijklm1xy_1zc=0;
    end
    
    if zz>=1 
        P_ijklm1xyz_1c=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm+1),num2str(xx),num2str(yy),num2str(zz-1),num2str(ch)]);
        P_ijk1lmxyz_1c=eval(['P',num2str(ii),num2str(jj),num2str(kk+1),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz-1),num2str(ch)]);
        else
        P_ijklm1xyz_1c=0;
        P_ijk1lmxyz_1c=0;
    end
    
    if ch==8
        P_ijkmxyzc_S1=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+1)]);
    else
        P_ijkmxyzc_S1=0;
    end
    
    if ch==7
        P_ijkmxyzc_E1=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+1)]);
    else
        P_ijkmxyzc_E1=0;
    end
    
    if ch==6
        P_ijkmxyzc_E2=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+2)]);
    else
        P_ijkmxyzc_E2=0;
    end
    
    if ch==5
        P_ijkmxyzc_I1=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+1)]);
    else
        P_ijkmxyzc_I1=0;
    end
    
    if ch==4
        P_ijkmxyzc_I2_H=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+1)]);
    else
        P_ijkmxyzc_I2_H=0;
    end
    if ch==3
        P_ijkmxyzc_I2_W=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+1)]);
    else
        P_ijkmxyzc_I2_W=0;
     end
    if ch==2
        P_ijkmxyzc_I2_R=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+1)]);
        P_ijkmxyzc_A_R=eval(['P',num2str(ii),num2str(jj),num2str(kk),num2str(ll),num2str(mm),num2str(xx),num2str(yy),num2str(zz),num2str(ch+5)]);
    else
        P_ijkmxyzc_I2_R=0;
        P_ijkmxyzc_A_R=0;
    end
    
    % children population in each process
    c_S=CC(ch,1);
    c_E=CC(ch,2);
    c_A=CC(ch,3);
    c_I1=CC(ch,4);
    c_I2=CC(ch,5);
%     c_H=CC(ch,6);
%     c_W=CC(ch,7);
%     c_R=CC(ch,8);
  
      if t<=T1
        Pdot_new=beta_q*(-ii*(kk+ll+mm+c_A+c_I1+c_I2)*P_ijklmxyzc-c_S*(kk+ll+mm)*P_ijklmxyzc+(ii+1)*(kk+ll+mm)* P_i1j_1klmxyzc)+...
                1/tau1*(-(jj+c_E)*P_ijklmxyzc+(1-a)*(jj+1)*P_ij1k_1lmxyzc+a*(jj+1)* P_ij1kl_1mxyzc)+...
                1/tau2*(-(ll+c_I1)*P_ijklmxyzc+(ll+1)*P_ijkl1m_1xyzc)+...
                gamma_a*(-(kk+c_A)*P_ijklmxyzc+(kk+1)*P_ijk1lmxyz_1c)+gamma_m*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xyz_1c)+...
                theta_ha*(-mm*P_ijklmxyzc+(mm+1)*P_ijklm1x_1yzc)+theta_hc*(-c_I2*P_ijklmxyzc)+...
                theta_i*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xy_1zc)+...
                beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+...
                beta_ga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-ii*P_ijklmxyzc+(ii+1)* P_i1j_1klmxyzc);
         Pdot_new_c=beta_q*(-c_S*(kk+ll+mm)*P_ijklmxyzc)+...
                 1/tau1*(-c_E*P_ijklmxyzc)+1/tau2*(-c_I1*P_ijklmxyzc)+...
                 gamma_a*(-c_A*P_ijklmxyzc)+gamma_m*(-c_I2*P_ijklmxyzc)+...
                 theta_hc*(-c_I2*P_ijklmxyzc)+theta_i*(-c_I2*P_ijklmxyzc)+...
                 beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                 1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                 gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                 beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1);     
      elseif t>T1 && ii==2 && c_S==1
          if schoolOpen==1
          Pdot_new=beta_q*(-ii*(kk+ll+mm+c_A+c_I1+c_I2)*P_ijklmxyzc-c_S*(kk+ll+mm)*P_ijklmxyzc+(ii+1)*(kk+ll+mm)* P_i1j_1klmxyzc)+...
                1/tau1*(-(jj+c_E)*P_ijklmxyzc+(1-a)*(jj+1)*P_ij1k_1lmxyzc)+a*(jj+1)* P_ij1kl_1mxyzc+...
                1/tau2*(-(ll+c_I1)*P_ijklmxyzc+(ll+1)*P_ijkl1m_1xyzc)+...
                gamma_a*(-(kk+c_A)*P_ijklmxyzc+(kk+1)*P_ijk1lmxyz_1c)+gamma_m*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xyz_1c)+...
                theta_ha*(-mm*P_ijklmxyzc+(mm+1)*P_ijklm1x_1yzc)+theta_hc*(-c_I2*P_ijklmxyzc)+...
                theta_i*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xy_1zc)+...
                beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                beta_ga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-ii*P_ijklmxyzc+(ii+1)* P_i1j_1klmxyzc)+...
                beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+...
                beta_sc*c_sc/(Ssc+Esc+Asc+Isc1+Isc2+eps)*(Asc+Isc1+Isc2)*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+gq;
            Pdot_new_c=beta_q*(-c_S*(kk+ll+mm)*P_ijklmxyzc)+...
                 1/tau1*(-c_E*P_ijklmxyzc)+1/tau2*(-c_I1*P_ijklmxyzc)+...
                 gamma_a*(-c_A*P_ijklmxyzc)+gamma_m*(-c_I2*P_ijklmxyzc)+...
                 theta_hc*(-c_I2*P_ijklmxyzc)+theta_i*(-c_I2*P_ijklmxyzc)+...
                 beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                 1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                 gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                 beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+gq+...
                 beta_sc*c_sc/(Ssc+Esc+Asc+Isc1+Isc2+eps)*(Asc+Isc1+Isc2)*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1);     
          else
              Pdot_new=beta_q*(-ii*(kk+ll+mm+c_A+c_I1+c_I2)*P_ijklmxyzc-c_S*(kk+ll+mm)*P_ijklmxyzc+(ii+1)*(kk+ll+mm)* P_i1j_1klmxyzc)+...
                1/tau1*(-(jj+c_E)*P_ijklmxyzc+(1-a)*(jj+1)*P_ij1k_1lmxyzc)+a*(jj+1)* P_ij1kl_1mxyzc+...
                1/tau2*(-(ll+c_I1)*P_ijklmxyzc+(ll+1)*P_ijkl1m_1xyzc)+...
                gamma_a*(-(kk+c_A)*P_ijklmxyzc+(kk+1)*P_ijk1lmxyz_1c)+gamma_m*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xyz_1c)+...
                theta_ha*(-mm*P_ijklmxyzc+(mm+1)*P_ijklm1x_1yzc)+theta_hc*(-c_I2*P_ijklmxyzc)+...
                theta_i*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xy_1zc)+...
                beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+...
                beta_ga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-ii*P_ijklmxyzc+(ii+1)* P_i1j_1klmxyzc)+gq;
             Pdot_new_c=beta_q*(-c_S*(kk+ll+mm)*P_ijklmxyzc)+...
                 1/tau1*(-c_E*P_ijklmxyzc)+1/tau2*(-c_I1*P_ijklmxyzc)+...
                 gamma_a*(-c_A*P_ijklmxyzc)+gamma_m*(-c_I2*P_ijklmxyzc)+...
                 theta_hc*(-c_I2*P_ijklmxyzc)+theta_i*(-c_I2*P_ijklmxyzc)+...
                 beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                 1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                 gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                 beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+gq;     
          end
              
      else
          if schoolOpen==1
          Pdot_new=beta_q*(-ii*(kk+ll+mm+c_A+c_I1+c_I2)*P_ijklmxyzc-c_S*(kk+ll+mm)*P_ijklmxyzc+(ii+1)*(kk+ll+mm)* P_i1j_1klmxyzc)+...
                1/tau1*(-(jj+c_E)*P_ijklmxyzc+(1-a)*(jj+1)*P_ij1k_1lmxyzc)+a*(jj+1)* P_ij1kl_1mxyzc+...
                1/tau2*(-(ll+c_I1)*P_ijklmxyzc+(ll+1)*P_ijkl1m_1xyzc)+...
                gamma_a*(-(kk+c_A)*P_ijklmxyzc+(kk+1)*P_ijk1lmxyz_1c)+gamma_m*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xyz_1c)+...
                theta_ha*(-mm*P_ijklmxyzc+(mm+1)*P_ijklm1x_1yzc)+theta_hc*(-c_I2*P_ijklmxyzc)+...
                theta_i*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xy_1zc)+...
                beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                beta_ga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-ii*P_ijklmxyzc+(ii+1)* P_i1j_1klmxyzc)+...
                beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+...
                beta_sc*c_sc/(Ssc+Esc+Asc+Isc1+Isc2+eps)*(Asc+Isc1+Isc2)*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1);
            Pdot_new_c=beta_q*(-c_S*(kk+ll+mm)*P_ijklmxyzc)+...
                 1/tau1*(-c_E*P_ijklmxyzc)+1/tau2*(-c_I1*P_ijklmxyzc)+...
                 gamma_a*(-c_A*P_ijklmxyzc)+gamma_m*(-c_I2*P_ijklmxyzc)+...
                 theta_hc*(-c_I2*P_ijklmxyzc)+theta_i*(-c_I2*P_ijklmxyzc)+...
                 beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                 1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                 gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                 beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+...
                 beta_sc*c_sc/(Ssc+Esc+Asc+Isc1+Isc2+eps)*(Asc+Isc1+Isc2)*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1);     
          else
              Pdot_new=beta_q*(-ii*(kk+ll+mm+c_A+c_I1+c_I2)*P_ijklmxyzc-c_S*(kk+ll+mm)*P_ijklmxyzc+(ii+1)*(kk+ll+mm)* P_i1j_1klmxyzc)+...
                1/tau1*(-(jj+c_E)*P_ijklmxyzc+(1-a)*(jj+1)*P_ij1k_1lmxyzc)+a*(jj+1)* P_ij1kl_1mxyzc+...
                1/tau2*(-(ll+c_I1)*P_ijklmxyzc+(ll+1)*P_ijkl1m_1xyzc)+...
                gamma_a*(-(kk+c_A)*P_ijklmxyzc+(kk+1)*P_ijk1lmxyz_1c)+gamma_m*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xyz_1c)+...
                theta_ha*(-mm*P_ijklmxyzc+(mm+1)*P_ijklm1x_1yzc)+theta_hc*(-c_I2*P_ijklmxyzc)+...
                theta_i*(-(mm+c_I2)*P_ijklmxyzc+(mm+1)*P_ijklm1xy_1zc)+...
                beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1)+...
                beta_ga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-ii*P_ijklmxyzc+(ii+1)* P_i1j_1klmxyzc);
            Pdot_new_c=beta_q*(-c_S*(kk+ll+mm)*P_ijklmxyzc)+...
                 1/tau1*(-c_E*P_ijklmxyzc)+1/tau2*(-c_I1*P_ijklmxyzc)+...
                 gamma_a*(-c_A*P_ijklmxyzc)+gamma_m*(-c_I2*P_ijklmxyzc)+...
                 theta_hc*(-c_I2*P_ijklmxyzc)+theta_i*(-c_I2*P_ijklmxyzc)+...
                 beta_q*(kk+ll+mm)*P_ijkmxyzc_S1+1/tau1*(1-a)*P_ijkmxyzc_E1+1/tau1*a*P_ijkmxyzc_E2+...
                 1/tau2*P_ijkmxyzc_I1+theta_hc*P_ijkmxyzc_I2_H+theta_i*P_ijkmxyzc_I2_W+...
                 gamma_a*P_ijkmxyzc_A_R+gamma_m*P_ijkmxyzc_I2_R+...
                 beta_sc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))*(-c_S*P_ijklmxyzc+P_ijkmxyzc_S1);     
          end
          
      end
%      if isnan(Pdot_new)
%          1
%      end
    Pdot(count)=Pdot_new;
    Sgc_dot=Sgc_dot+c_S*Pdot_new_c;
    Egc_dot=Egc_dot+c_E*Pdot_new_c;
    Agc_dot=Agc_dot+c_A*Pdot_new_c;
    Igc1_dot=Igc1_dot+c_I1*Pdot_new_c;
    Igc2_dot=Igc2_dot+c_I2*Pdot_new_c;
    
    Sha_dot=Sha_dot+ii*Pdot_new;
    Eha_dot=Eha_dot+jj*Pdot_new;
    Aha_dot=Aha_dot+kk*Pdot_new;
    Iha1_dot=Iha1_dot+ll*Pdot_new;
    Iha2_dot=Iha2_dot+mm*Pdot_new;

    Ega_temp=Ega_temp+beta_q*ii*(kk+ll+mm+c_A+c_I1+c_I2)*P_ijklmxyzc;
    Egc_temp=Egc_temp+beta_q*c_S*(kk+ll+mm)*P_ijklmxyzc;
    
    count=count+1;
    
%     if ll==1 
%         Sha_temp1=Sha_temp1+ll*Pdot_new;
%     end
%     
%     if ll==2 
%         Sha_temp2=Sha_temp2+ll*Pdot_new;
%     end
%     
%     if ll==2&& ch==9 && Pdot_new<0
%         1
%     end
        
end
%Pdot
% Sgc_dot
% Egc_dot
% Agc_dot
% Igc1_dot
% Igc2_dot
% Sha_temp1
% Sha_temp2
% if Iha1_dot<0
%     1
% end
if t<=T1
xdot=[-beta_ga*Sga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-Ega_temp;
      beta_ga*Sga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-1/tau1*Ega+Ega_temp;
      (1-a)/tau1*Ega-gamma_a*Aga;
      a/tau1*Ega-1/tau2*Iga1;
      1/tau2*Iga1-theta_ha*Iga2-theta_i*Iga2-gamma_m*Iga2-q_g2*Iga2;
      -beta_sc*Sgc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-Egc_temp;
      beta_sc*Sgc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-1/tau1*Egc+Egc_temp;
      (1-a)/tau1*Egc-gamma_a*Agc;
      a/tau1*Egc-1/tau2*Igc1;
      1/tau2*Igc1-theta_hc*Igc2-theta_i*Igc2-gamma_m*Igc2-q_g2*Igc2;
      0;
      0;
      0;
      0;
      0;
      theta_ha*Iga2+theta_hc*Igc2-(gamma+d)*H+sigma*W;
      theta_i*(Iga2+Igc2)-gamma_m*W-sigma*W;
      0;
      0;
      gamma_a*(Aga+Agc)+gamma_m*(Iga2+Igc2)+gamma*H+gamma_m*W;
      d*H; 
      1/tau2*Iga1;
      1/tau2*Igc1;
      Sha_dot;
      Eha_dot;
      Aha_dot;
      Iha1_dot;
      Iha2_dot;
      Pdot];
elseif t> T1 && schoolOpen==1
    xdot=[-beta_ga*Sga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-Ega_temp+2*gq*p_c*Sqa;
       beta_ga*Sga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-1/tau1*Ega+Ega_temp;
      (1-a)/tau1*Ega-gamma_a*Aga;
      a/tau1*Ega-1/tau2*Iga1;
      1/tau2*Iga1-theta_ha*Iga2-theta_i*Iga2-gamma_m*Iga2-q_g2*Iga2;
      -beta_sc*Sgc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-Egc_temp-beta_sc*c_sc*Ssc*(Asc+Isc1)/(Ssc+Esc+Asc+Isc1+Isc2)+gq*Sqc;
      beta_sc*Sgc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-1/tau1*Egc+Egc_temp+beta_sc*c_sc*Ssc*(Asc+Isc1)/(Ssc+Esc+Asc+Isc1+Isc2);
      (1-a)/tau1*Egc-gamma_a*Agc;
      a/tau1*Egc-1/tau2*Igc1;
      1/tau2*Igc1-theta_hc*Igc2-theta_i*Igc2-gamma_m*Igc2-q_g2*Igc2;
      -beta_sc*c_sc*Ssc*(Asc+Isc1)/(Ssc+Esc+Asc+Isc1+Isc2);
      beta_sc*c_sc*Ssc*(Asc+Isc1)/(Ssc+Esc+Asc+Isc1+Isc2)-1/tau1*Esc;
      (1-a)/tau1*Esc-gamma_a*Asc;
      a/tau1*Esc-1/tau2*Isc1;
      1/tau2*Isc1-q_sc*Isc2;
      theta_ha*Iga2+theta_hc*Igc2-(gamma+d)*H+sigma*W;
      theta_i*(Iga2+Igc2)-gamma_m*W-sigma*W;
      -2*gq*p_c*Sqa;
      -gq*Sqc;
      gamma_a*(Aga+Agc)+gamma_m*(Iga2+Igc2)+gamma*H+gamma_m*W;
      d*H; 
      1/tau2*Iga1;
      1/tau2*Igc1;
      Sha_dot;
      Eha_dot;
      Aha_dot;
      Iha1_dot;
      Iha2_dot;
      Pdot];
else
    xdot=[-beta_ga*Sga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-Ega_temp+2*gq*p_c*Sqa;
      beta_ga*Sga*(c_ga*(Aga+Iga1+Iga2)+c_ac*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-1/tau1*Ega+Ega_temp;
      (1-a)/tau1*Ega-gamma_a*Aga;
      a/tau1*Ega-1/tau2*Iga1;
      1/tau2*Iga1-theta_ha*Iga2-theta_i*Iga2-gamma_m*Iga2-q_g2*Iga2;
      -beta_sc*Sgc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-Egc_temp+gq*Sqc;
      beta_sc*Sgc*(c_ac*(Aga+Iga1+Iga2)+c_cc*(Agc+Igc1+Igc2))/(Sga+Ega+Aga+Iga1+Iga2+(Sgc+Egc+Agc+Igc1+Igc2))-1/tau1*Egc+Egc_temp;
      (1-a)/tau1*Egc-gamma_a*Agc;
      a/tau1*Egc-1/tau2*Igc1;
      1/tau2*Igc1-theta_hc*Igc2-theta_i*Igc2-gamma_m*Igc2-q_g2*Igc2;
      0;
      0;
      0;
      0;
      0;
      theta_ha*Iga2+theta_hc*Igc2-(gamma+d)*H+sigma*W;
      theta_i*(Iga2+Igc2)-gamma_m*W-sigma*W;
      -2*gq*p_c*Sqa;
      -gq*Sqc;
      gamma_a*(Aga+Agc)+gamma_m*(Iga2+Igc2)+gamma*H+gamma_m*W;
      d*H; 
      1/tau2*Iga1;
      1/tau2*Igc1;
      Sha_dot;
      Eha_dot;
      Aha_dot;
      Iha1_dot;
      Iha2_dot;
      Pdot];
end