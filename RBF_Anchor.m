% Randomly select m anchors from data X
%
% X = data as n x d matrix
% m = number of anchors
% A = anchor data as m x d matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A] = RBF_Anchor(X,m)

    [n,~] = size(X);

    c=randperm(n);
    A=X(c(1:m),:); % 从n个样本中随机选取m个锚点

end