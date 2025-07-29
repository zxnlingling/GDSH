function[num,numH2] = foundHamming(th,tbf,comspace,Y_te,Y_tr,HamRidus)
% load('cifar10.mat')
cat=Y_te;
cat2=Y_tr;
% cat2=Y_te;
[~,c]=size(Y_te);
% size(Y_te)
% comspace=comspace(1:20000,:);
% cat2=cat2(1:20000);
[m2,~]=size(comspace);
num=zeros(m2,1);
tbf=tbf(ones(1,m2),:);
dis=zeros(m2,1);
  tbf=int8(tbf);
   comspace=int8(comspace);
    dis=sum(bitxor(tbf,comspace),2);
%      save('dis.mat','dis');
numH2=sum(dis<=HamRidus);
%  disp(numH2)
dis2=horzcat(dis,cat2);

dis=sortrows(dis2,1);

sx=1;
for k=1:m2
       if  sum(cat(th,:).*dis(k,2:c+1))>0
           %cat(th)-dis(k,2))==0
         num(sx,1)=k;
       end      
        sx=sx+1;   
end
sx=1;
end
  