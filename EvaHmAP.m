function[beatnb] = EvaHmAP(L_re,L_query,B_te,B_re,HamRidus)

    %  load('COCO_end.mat');
    % load('bvar12.mat');


    Y_te=L_query;
    Y_re=L_re;

    [dig,~]=size(L_query);   

    B=B_te;
    % B=(B+1)/2;
    H=B_re;

    comspace= H;
    comspace1=B;
        
    cc=0;
    nb=zeros(dig,1);
    %     tic;
    for i=1:dig   
        [a,numH2]=foundHamming(i,comspace1(i,:),comspace,Y_te,Y_re,HamRidus);  
        a=a(1:numH2);
        bbb=(a~=0);
        bbb=sum(bbb(:));
        for m=1:numH2
            if a(m)~=0
                cc=cc+1;            
                nb(i,1)=nb(i,1)+1/bbb*cc/a(m);
            end
        end
        cc=0; 
    end
    beatnb=mean(nb);
    %  toc;
end