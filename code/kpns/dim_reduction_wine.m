%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/wine.mat');
wine = wine(1:59,:);
rng(0);
wine = wine'
%wine = normc(wine');
PGS =1;
options.KernelType='Gaussian';
options.degree=3;
[Mapping,BkGm,R_kernel,Res,QDR_KPNS_Gauss] = kernel_pnsMain(wine,1,PGS,options);
options.fileName='KPCA_Gaussian';
[ eigvec, eig_val,QDR_KPCA_Gauss ] = kpca_main(wine,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);
options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel_np3,Res,QDR_KPNS_NPoly_3] = kernel_pnsMain(wine,1,PGS,options);
[ eigvec, eig_val, QDR_KPCA_NPoly_3 ] = kpca_main(wine,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kernel_np5,Res,QDR_KPNS_NPoly_5] = kernel_pnsMain(wine,1,PGS,options);
[ eigvec, eig_val,QDR_KPCA_NPoly_3 ] = kpca_main(wine,options);
R_kpca_5 = 100*eig_val/sum(eig_val);
options.KernelType='Linear';
[ eigvec, eig_val,QDR_KPCA_linear ] = kpca_main(wine,options);
R_linear = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(wine,options);
R_kpca_5 = 100*eig_val/sum(eig_val);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(QDR_KPNS_Gauss(2,:),QDR_KPNS_Gauss(1,:),'r-');
hold on;
plot(QDR_KPCA_Gauss(2,:),QDR_KPCA_Gauss(1,:),'b-');
hold on;

plot(QDR_KPNS_NPoly_3(2,:),QDR_KPNS_NPoly_3(1,:),'y-','LineWidth',2);
hold on;
plot(QDR_KPCA_NPoly_3(2,:),QDR_KPCA_NPoly_3(1,:),'g-');
hold on;

plot(QDR_KPNS_NPoly_5(2,:),QDR_KPNS_NPoly_5(1,:),'m-');
hold on
plot(QDR_KPCA_NPoly_5(2,:),QDR_KPCA_NPoly_5(1,:),'c-');
hold on

plot(QDR_KPCA_linear(2,:),QDR_KPCA_linear(1,:),'k-');
%%%%%%%%%%%%%%%
title('Wine')
xlabel('k-Neighbourhood');
ylabel('Quality of DR');
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA','Location', 'southeast')
axis([1,size(Data,2),0,1.1]) 


Total_R = [R_kernel(1:3) R_kernel_np3(1:3) R_kernel_np5(1:3)   R_kpca_gauss(1:3) R_kpca_3(1:3) R_kpca_5(1:3) R_linear(1:3)]