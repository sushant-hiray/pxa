%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/CNAE9.mat');
CNAE9 = CNAE9(:,2:end);
rng(0);
CNAE9 = normc(CNAE9');
PGS =1;
options.KernelType='Gaussian';
%[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(CNAE9,1,PGS,options);
%[Mapping,BkGm,R_normal,NewBPData,Res] = pnsMain(CNAE9,1,PGS);
[ eigvec, eig_val ] = kpca_main(CNAE9,options);
R_kpca = 100*eig_val/sum(eig_val);
options.KernelType='Linear'
[ eigvec, eig_val ] = kpca_main(CNAE9,options);
R_linear = 100*eig_val/sum(eig_val);

Total_R = [R_kernel(1:10) R_kpca(1:10) R_normal(1:10) R_linear(1:10)]