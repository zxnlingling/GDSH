% Compute kernelized features using the Gaussian kernel (or the Gaussian RBF)
%
% X = data as n x d matrix
% m = number of anchors
% A = anchor data as m x d matrix
% PhiX = kernelized data as m x n matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [PhiX] = RBF_Kernelization(X,m,A,sigma)

    [n,~] = size(X);
    
    PhiX=zeros(m,n);
    D=zeros(n,m);
    for i=1:n
        for j=1:m
            D(i,j)=norm(X(i,:)-A(j,:),2)^2;
            PhiX(j,i) = exp(-D(i,j)./2/sigma^2);
        end
    end
    
end