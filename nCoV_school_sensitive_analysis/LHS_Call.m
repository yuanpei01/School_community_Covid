 function s=LHS_Call(xmin,xmean,xmax,xsd,nsample,distrib,threshold)

if nsample==1
    s=xmean;
    return
end
if nargin<7
    threshold=1e20;
end

[sample,nvar]=size(xmean);
% if distrib=='norm'
%    if xmean==17.334648
%     rng(1733,'twister');
%    end
%     ran=rand(nsample,nvar);
%     s=zeros(nsample,nvar);
%     for j=1: nvar
%         idx=randperm(nsample);
%         P =(idx'-ran(:,j))/nsample;
%         s(:,j)=xmean(j)+P/norm(P,2).*xsd(j);
%     end
% end
    
if distrib == 'unif'  
    if xmin==0
        xmin=1e-300;
    end
    nvar=length(xmin);
%     if xmax==9.3186e+03 && xmin==7.3186e+03
%     rng(7466,'twister');
%     else
%      if xmax==1.13186e+04
%     rng(5402,'twister');
%      end
%          if xmax == 2&& xmin==0
%     rng(8333,'twister');
%          end 
%                if xmax == 1.0355&& xmin==0.9842
%     rng(8223,'twister');
%                end 
%                    if xmax == 1&& xmin==3.5
%     rng(45555,'twister');
%                    end 
%                     if xmax == 1&& xmin==3
%     rng(2444,'twister');
%                     end 
%                        if xmax ==1.582/7+0.1
%     rng(29977,'twister');
%                        end 
%                           if xmax ==0.1429+0.1
%     rng(23333,'twister');
%                     end 
%     end
end
 
    
    ran=rand(nsample,nvar);
    s=zeros(nsample,nvar);
    for j=1: nvar
        idx=randperm(nsample);
        P =(idx'-ran(:,j))/nsample;
        xmax(j);
        xmin(j);
        xmax(j)/xmin(j);
        if (xmax(j)<1 & xmin(j)<1) || (xmax(j)>1 & xmin(j)>1)
            'SAME RANGE';
            if (xmax(j)/xmin(j))<threshold 
                '<1e3: LINEAR SCALE';
                s(:,j) = xmin(j) + P.* (xmax(j)-xmin(j));
            else
                '>=1e3: LOG SCALE';
                s(:,j) = log(xmin(j)) + P.*abs(abs(log(xmax(j)))-abs(log(xmin(j))));
                s(:,j) = exp(s(:,j));
            end
        else
            'e- to e+';
            if (xmax(j)/xmin(j))<threshold 
                '<1e3: LINEAR SCALE';
                s(:,j) = xmin(j) + P.* (xmax(j)-xmin(j));
            else
                '>=1e3: LOG SCALE';
                s(:,j) = log(xmin(j)) + P.*abs(log(xmax(j))-log(xmin(j)));
                s(:,j) = exp(s(:,j));
            end
        end
    end
end