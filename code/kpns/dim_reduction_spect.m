%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/SPECT.mat');
SPECT = SPECT(:,1:end);
rng(0);
SPECT = normc(SPECT');
PGS =1;
options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(SPECT,1,PGS,options);

[Mapping,BkGm,R_normal,NewBPData,Res] = pnsMain(SPECT,1,PGS);
[ eigvec, eig_val ] = kpca_main(SPECT,options);
R_kpca = 100*eig_val/sum(eig_val);
options.KernelType='Linear'
[ eigvec, eig_val ] = kpca_main(SPECT,options);
R_linear = 100*eig_val/sum(eig_val);

Total_R = [R_kernel(1:10) R_kpca(1:10) R_normal(1:10) R_linear(1:10)]