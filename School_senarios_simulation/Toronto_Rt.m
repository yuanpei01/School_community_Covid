% plot the Rt
% stage 1, 2,3

Tor_a= xlsread('Toronto_Rt_a_1123');
Tor_c= xlsread('Toronto_Rt_c_1123');

Tor_Rt_a=Tor_a(:,4);
Tor_Rt_a_min=Tor_a(:,6);
Tor_Rt_a_max=Tor_a(:,12);

Tor_Rt_c=Tor_c(:,4);
Tor_Rt_c_min=Tor_c(:,6);
Tor_Rt_c_max=Tor_c(:,12);

Num_data=length(Tor_a)+7;
Num_sim=length(Tor_a);
time_plot_1=8:1:Num_data;
shade_min=zeros(Num_sim,1)-1;
shade_max=zeros(Num_sim,1)+4;

figure(1);clf
xconf = [time_plot_1 time_plot_1(end:-1:1)] ;%????         
yconf = [Tor_Rt_c_min(1:Num_sim)' Tor_Rt_c_max(Num_sim:-1:1)'];
p = fill(xconf,yconf,'r','FaceColor',[0.75 0.75 0.75],'EdgeColor','none','FaceAlpha',.6);%FaceColor??????EdgeColor?????
hold on
xconf = [time_plot_1 time_plot_1(end:-1:1)] ;%????         
yconf = [Tor_Rt_a_min(1:Num_sim)' Tor_Rt_a_max(Num_sim:-1:1)'];
p = fill(xconf,yconf,'r','FaceColor',[1,0.8,0.8],'EdgeColor','none','FaceAlpha',.8);%FaceColor??????EdgeColor?????
hold on
h1=plot([8:Num_data],Tor_Rt_a,'color','r');
hold on
h2=plot([8:Num_data],Tor_Rt_c,'color',[0.85 0.325 0.098]);
hold on
plot([1,Num_data],[1,1],'k-');
hold on
plot([40,40],[-0.5 5],'-','color',[0 0.447 0.741]);
hold on
plot([66,66],[-0.5 5],'-','color',[0 0.447 0.741]);
hold on
plot([94,94],[-0.5 5],'-','color',[0 0.447 0.741]);
text(20,3,['R_{ta}=',num2str(roundn(mean(Tor_Rt_a(1:33)),-2))],'color','r','FontSize',12)
text(50,3,['R_{ta}=',num2str(roundn(mean(Tor_Rt_a(34:55)),-2))],'color','r','FontSize',12)
text(75,3,['R_{ta}=',num2str(roundn(mean(Tor_Rt_a(56:87)),-2))],'color','r','FontSize',12)
text(100,3,['R_{ta}=',num2str(roundn(mean(Tor_Rt_a(88:109)),-2))],'color','r','FontSize',12)
text(20,2.5,['R_{tc}=',num2str(roundn(mean(Tor_Rt_c(1:33)),-2))],'color',[0.85 0.325 0.098],'FontSize',12)
text(50,2.5,['R_{tc}=',num2str(roundn(mean(Tor_Rt_c(34:55)),-2))],'color',[0.85 0.325 0.098],'FontSize',12)
text(75,2.5,['R_{tc}=',num2str(roundn(mean(Tor_Rt_c(56:87)),-2))],'color',[0.85 0.325 0.098],'FontSize',12)
text(100,2.5,['R_{tc}=',num2str(roundn(mean(Tor_Rt_c(88:109)),-2))],'color',[0.85 0.325 0.098],'FontSize',12)
legend([h1 h2],'Adults(>19)','Children and youth(19 and younger)')
ylabel('R_t')
xlim([1 Num_data])
ylim([0.5 5])
xticks([1 30 60 90 116])
xticklabels({'7/31','8/29','9/28','10/28','11/23'})
set(get(gca,'XLabel'),'FontSize',14);%?????8 point??5?
set(get(gca,'YLabel'),'FontSize',14);
set(get(gca,'Children'),'linewidth',2.0);  %?????'linewidth'??????'MarkerSize'
%set(get(gca,'Children'),'MarkerSize',10);
set(gca,'FontSize',13,'linewidth',1.5)
set(gca, 'Box', 'off', 'TickDir', 'out', 'TickLength', [.02 .02], ...
    'XMinorTick', 'on', 'YMinorTick', 'off', 'YGrid', 'off', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 1)
% print('-f1','-djpeg','-r600','./school_plot_1203/Rt_1203.jpeg')