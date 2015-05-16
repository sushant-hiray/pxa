clc
clear all
close all
rng(0)
DatabasePath='../../data/ORL/s'; % DatabasePath
ss=10; % sample set size
ns=40; % number of subjects

% No ofRows = no of pixels in one images
% No of cols = no of images
Data=[];

for td = 1:ns
    Files = dir(strcat(DatabasePath,int2str(td)));
    for i = 1:size(Files,1)
        if not(strcmp(Files(i).name,'.')|strcmp(Files(i).name,'..'))
            img = imread(strcat(DatabasePath,int2str(td),'/',Files(i).name));
            [irow, icol, dim] = size(img);
            if dim>1
                img=rgb2gray(img);
            end
            temp = reshape(img,irow*icol,1);   % Reshaping 2D images into 1D image vectors
            Data = [Data temp];
        end
    end
end

Data = double(Data);
% Each column of data is an image reduced to one dimension

% preprocessing
Data = Data - repmat(mean(Data), size(Data,1), 1);
Data = normc(Data);



PGS =1;


options.KernelType='Gaussian';
[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(Data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(Data,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);


options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel_np3,Res] = kernel_pnsMain(Data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(Data,options);
R_kpca_np3 = 100*eig_val/sum(eig_val);


options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kernel_np5,Res] = kernel_pnsMain(Data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(Data,options);
R_kpca_np5 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=3;
[ eigvec, eig_val ] = kpca_main(Data,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(Data,options);
R_kpca_5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val ] = kpca_main(Data,options);
R_linear = 100*eig_val/sum(eig_val);
% X_mean = mean(Data,2);
% X_shift = Data -X_mean(:,ones(1,size(Data,2)));
% [eigvec eigv ] = svd(X_shift);

Total_R = [R_kernel(1:4) R_kpca_gauss(1:4) R_kernel_np3(1:4) R_kernel_np5(1:4) R_kpca_np3(1:4) R_kpca_np5(1:4) R_kpca_3(1:4) R_kpca_5(1:4) R_linear(1:4)]