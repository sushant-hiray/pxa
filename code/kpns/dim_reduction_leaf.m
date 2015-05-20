%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/leaf.mat');
Data=leaf';

Data = double(Data);

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
[Mapping,BkGm,R_pns,Res] = kernel_pnsMain(Data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(Data,options);
R_linear = 100*eig_val/sum(eig_val);
% X_mean = mean(Data,2);
% X_shift = Data -X_mean(:,ones(1,size(Data,2)));
% [eigvec eigv ] = svd(X_shift);

Total_R = [R_kernel(1:10) R_kpca_gauss(1:10) R_kernel_np3(1:10) R_kernel_np5(1:10) R_kpca_np3(1:10) R_kpca_np5(1:10) R_kpca_3(1:10) R_kpca_5(1:10) R_linear(1:10) R_pns(1:10)]