%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/iris.mat');
iris = iris(:,1:4);
rng(0);
%iris = normc(iris');
PGS =1;
iris = iris';

options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel,Res] = kernel_pnsMain(iris,1,PGS,options);

[ eigvec, eig_val ] = kpca_main(iris,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=3;
[ eigvec, eig_val ] = kpca_main(iris,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(iris,options);
R_kpca_5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val ] = kpca_main(iris,options);
R_linear = 100*eig_val/sum(eig_val);


Total_R = [R_kernel(1:3) R_kpca_gauss(1:3) R_kpca_3(1:3) R_kpca_5(1:3) R_linear(1:3)]
