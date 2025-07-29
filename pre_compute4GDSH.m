% Compute LU, L, X, XX,X_query,X_re,L_re,L_query
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pre_compute4GDSH(ratio,dataset)    
    %% load data
    file1=strcat(dataset,'_');
    file1=strcat(file1,num2str(ratio));
    file1=strcat(file1,'%Sup.mat');
    filesource='D:\MATLAB\SSUH\DeepFeature_Semi\';
    filesource=strcat(filesource,dataset);
    filesource=strcat(filesource,'\');
    file1=strcat(filesource,file1);
    load(file1);
    % I_tr_sup,I_tr_unsup,I_query,I_re,L_tr_sup,L_tr_unsup,L_query,L_re
   
    L0=L_tr_sup;
    
    if strcmp(dataset,'Cifar10') % sigma: bandwidth parameter
        sigma=3; delta1 = 0.1; delta2=1e-5; 
    end
    if strcmp(dataset,'KCaltech101')
        sigma=6; delta1 = 0.1; delta2=1e-7; 
    end
    if strcmp(dataset,'ImageNet')
        sigma=8; delta1 = 0.1; delta2=1e-7;  
    end
    if strcmp(dataset,'COCO')
        sigma=1.4; delta1 = 0.1; delta2= 1e-4;  
    end
    if strcmp(dataset,'NUS_WIDE')
        sigma=2.5; delta1 = 0.1; delta2 = 1e-4; 
    end
    if strcmp(dataset,'MIRFLICKR_CLIP')
        delta1 = 0.1; delta2 = 1e-4;
    end

    %% kernelization
    d=500;
    [A] = RBF_Anchor(I_tr_sup,d);
    [X0] = RBF_Kernelization(I_tr_sup,d,A,sigma);
    [XU] = RBF_Kernelization(I_tr_unsup,d,A,sigma);
    X0 = X0'; 
    XU = XU';

    if strcmp(dataset,'MIRFLICKR_CLIP')
        X0 = I_tr_sup; 
        XU = I_tr_unsup;
    end
    
    %% Pseudo_labeling
    [LU_NonL21,~] = Pseudo_labeling_L21(X0,XU,L0,delta1,delta2);
    [c,n_n0] = size(LU_NonL21);
    [~,index]=max(LU_NonL21,[],1); 
    LU = zeros(c, n_n0);
    for i=1:n_n0
        LU(index(i),i)=1; % 取top-1伪标签
    end
    if strcmp(dataset,'COCO')
        LU=LU_NonL21; % for multi-label datasets
    end
    if strcmp(dataset,'NUS_WIDE')
        LU=LU_NonL21; 
    end
    if strcmp(dataset,'MIRFLICKR_CLIP')
        LU=LU_NonL21; 
    end
    
    L=[L0' LU];
    X=[X0' XU']; 
    XX=X*X';
    
    [X_query] = RBF_Kernelization(I_query,d,A,sigma);
    X_query=X_query';
    [X_re] = RBF_Kernelization(I_re,d,A,sigma);
    X_re=X_re';

    if strcmp(dataset,'MIRFLICKR_CLIP')
        X_query=I_query;
        X_re=I_re;
    end
    
    file2=strcat('pre_compute4GDSH_',dataset); 
    if strcmp(dataset,'COCO')
        file2=strcat('pre_compute4GDSH_realValue_',dataset); 
    end
    if strcmp(dataset,'NUS_WIDE')
        file2=strcat('pre_compute4GDSH_realValue_',dataset); 
    end
    if strcmp(dataset,'MIRFLICKR_CLIP')
        file2=strcat('pre_compute4GDSH_realValue_',dataset); 
    end
    file2=strcat(file2,'_');
    file2=strcat(file2,num2str(ratio));
    file2=strcat(file2,'%Sup.mat');
    filesource2='D:\MATLAB\SSUH\DeepFeature_Semi\pre_compute4SSH\';
    file2=strcat(filesource2,file2);
    save(file2,'X','LU','L','XX','X_query','X_re','L_query','L_re');
    
end