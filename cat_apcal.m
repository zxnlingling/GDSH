 function [ap] = cat_apcal(kkk,traingnd,testgnd, IX)
% ap=apcal(score,label)
% average precision (AP) calculation 


% IX=HammingRank;
[numtrain, numtest] = size(IX);

apall = zeros(1,numtest);
for i = 1 : numtest
    y = IX(:,i);
    x=0;
    p=0; 
    new_label=zeros(1,numtrain);
%     new_label(traingnd==testgnd(i))=1;
% for aaa=1:numtrain
%     if(sum(traingnd(aaa,:).*testgnd(i,:))>0)
%     new_label(aaa)=1;
%     end
% end
%      new_label=sum(traingnd .*testgnd(i,:),2)>0;
    new_label(sum(traingnd .*testgnd(i,:),2)>0)=1;
    num_return_NN = kkk;%5000; % only compute MAP on returned top 5000 neighbours.
    for j=1:num_return_NN
        if new_label(y(j))==1
            x=x+1;
            p=p+x/j;
        end
    end  
    if p==0
        apall(i)=0;
    else
        apall(i)=p/x;
    end
    
    
end

ap = mean(apall);
  end