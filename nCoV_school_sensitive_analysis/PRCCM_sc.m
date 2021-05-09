function [prcc sign0 sign_label]=PRCCM_sc(LHSmatrix,Y,s,PRCC_var,alpha);

Y=Y(s,:)';
[a k]=size(LHSmatrix); 
[b out]=size(Y);
for i=1:k  
    c=['LHStemp=LHSmatrix;LHStemp(:,',num2str(i),')=[];Z',num2str(i),'=LHStemp;LHStemp=[];'];
    eval(c);
    
    c1=['[LHSmatrix(:,',num2str(i),'),Y];'];
    c2=['Z',num2str(i)];
    [rho,p]=partialcorr(eval(c1),eval(c2),'type','Spearman');
    for j=1:out
        c3=['prcc_',num2str(i),'(',num2str(j),')=rho(1,',num2str(j+1),');'];
        c4=['prcc_sign_',num2str(i),'(',num2str(j),')=p(1,',num2str(j+1),');'];
        eval(c3);
        eval(c4);
    end
    c5=['clear Z',num2str(i),';'];
    eval(c5);
end
prcc=[];
prcc_sign=[];
for i=1:k
    d1=['prcc=[prcc ; prcc_',num2str(i),'];'];
    eval(d1);
    d2=['prcc_sign=[prcc_sign ; prcc_sign_',num2str(i),'];'];
    eval(d2);
end
[length(s) k out];
PRCCs=prcc';
uncorrected_sign=prcc_sign';
prcc=PRCCs;
sign0=uncorrected_sign;

sign_label_struct=struct;
sign_label_struct.uncorrected_sign=uncorrected_sign;

for r=1:length(s)
    a=find(uncorrected_sign(r,:)<alpha);
    PRCC_var(a);
    prcc(r,a);
    b=num2str(prcc(r,a));
    sign_label_struct.index{r}=a;
    sign_label_struct.label{r}=PRCC_var(a);
    sign_label_struct.value{r}=b;
    
    figure 
    bar(PRCCs(r,:));
    hold on;
    a0 = plot(a,sign(PRCCs(r,a)).*(abs(PRCCs(r,a))+0.025),'k*'); hold off;
    legend(a0,sprintf( '%s\n%s', 'siginificant' , ['( p < ', num2str(alpha),')']) ) ;
    set(gca,'XTickLabel',PRCC_var,'XTick',[1:k]);
    xlabel('Parameters') 
    ylabel('PRCCs for daly new cases of C&Y in school') 
    %C_{h_1}+C_{h_2}
end
sign_label=sign_label_struct;