%% COmments : KPNS > KPCA Guassian kernel 3-4%

clear
load('../../data/haberman.mat');
%sonar = sonar(:);
rng(0);
%sonar = normc(sonar');
PGS =1;
haberman = haberman';
options.KernelType='Gaussian';
options.degree=5;
[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(haberman,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(haberman,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel_np_3,Res] = kernel_pnsMain(haberman,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(haberman,options);
R_kpca_np_3 = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kernel_np_5,Res] = kernel_pnsMain(haberman,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(haberman,options);
R_kpca_np_5 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=3;
[ eigvec, eig_val ] = kpca_main(haberman,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(haberman,options);
R_kpca_5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val ] = kpca_main(haberman,options);
R_linear = 100*eig_val/sum(eig_val);
% X_mean = mean(sonar,2);
% X_shift = sonar -X_mean(:,ones(1,size(sonar,2)));
% [eigvec eigv ] = svd(X_shift);

Total_R = [R_kernel(1:10) R_kernel_np_3(1:10) R_kernel_np_5(1:10) R_kpca_np_3(1:10) R_kpca_np_5(1:10) R_kpca_gauss(1:10) R_kpca_3(1:10) R_kpca_5(1:10) R_linear(1:10)]