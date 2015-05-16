%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/SPECT2.mat');
SPECT = SPECT(:,1:end-1);
rng(0);
%SPECT = normc(SPECT');
PGS =1;
SPECT = SPECT';
options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(SPECT,1,PGS,options);

[ eigvec, eig_val ] = kpca_main(SPECT,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=3;
[ eigvec, eig_val ] = kpca_main(SPECT,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(SPECT,options);
R_kpca_5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val ] = kpca_main(SPECT,options);
R_linear = 100*eig_val/sum(eig_val);
% X_mean = mean(SPECT,2);
% X_shift = SPECT -X_mean(:,ones(1,size(SPECT,2)));
% [eigvec eigv ] = svd(X_shift);

Total_R = [R_kernel(1:5) R_kpca_gauss(1:5) R_kpca_3(1:5) R_kpca_5(1:5) R_linear(1:5)]