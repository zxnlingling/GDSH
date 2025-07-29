function [LU,P] = Pseudo_labeling_L21(X0,XU,L0,delta1,delta2)
%
% save LU_ImageL21

    [n0, d] = size(X0);
    [n_n0, ~] = size(XU);
    [~, c] = size(L0);    
    
    %% train Classifier 
    iter = 4;

    P = rand(d,c)-0.5;
    D = eye(n0);  
    a = rand(1,n0)-0.5;
    for t=1:iter
        P = pinv(X0'*X0+delta1*X0'*D*X0+delta2*eye(d))*X0'*L0;
        A = X0*P;
        for i=1:n0
            a(1,i)=0.5./norm(A(i,:),2);
        end
        D = diag(a);
    end

    %% labeling
    LU = XU*P;
    LU = LU';
    for jj=1:n_n0
        LU(:,jj) = (LU(:,jj)-min(LU(:,jj)))/(max(LU(:,jj))-min(LU(:,jj)));
    end

end