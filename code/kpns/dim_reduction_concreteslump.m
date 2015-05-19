%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/concreteslump.mat');
concreteslump = concreteslump';
rng(0);
%transfusion = normc(transfusion');
PGS =1;
concreteslump = concreteslump';
options.KernelType='Gaussian';
options.sigma = 2;
[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(concreteslump,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(concreteslump,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);


options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel_np3,Res] = kernel_pnsMain(concreteslump,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(concreteslump,options);
R_kpca_np3 = 100*eig_val/sum(eig_val);


options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kernel_np5,Res] = kernel_pnsMain(concreteslump,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(concreteslump,options);
R_kpca_np5 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=3;
[ eigvec, eig_val ] = kpca_main(concreteslump,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(concreteslump,options);
R_kpca_5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val ] = kpca_main(concreteslump,options);
R_linear = 100*eig_val/sum(eig_val);
% X_mean = mean(transfusion,2);
% X_shift = transfusion -X_mean(:,ones(1,size(transfusion,2)));
% [eigvec eigv ] = svd(X_shift);

Total_R = [R_kernel(1:4) R_kpca_gauss(1:4) R_kernel_np3(1:4) R_kernel_np5(1:4) R_kpca_np3(1:4) R_kpca_np5(1:4) R_kpca_3(1:4) R_kpca_5(1:4) R_linear(1:4)]