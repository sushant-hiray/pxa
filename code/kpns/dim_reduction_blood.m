%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/transfusion.mat');
transfusion = transfusion(:,2:end-1);
rng(0);
%transfusion = normc(transfusion');
PGS =1;
transfusion = transfusion';

options.KernelType='Gaussian';
options.degree=3;
[Mapping,BkGm,R_kernel,Res,QDR_KPNS_Gauss] = kernel_pnsMain(transfusion,1,PGS,options);
options.fileName='KPCA_Gaussian';
plot(QDR_KPNS_Gauss(2,:),QDR_KPNS_Gauss(1,:),'r-');
[ eigvec, eig_val,QDR_KPCA_Gauss ] = kpca_main(transfusion,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);
hold on;
plot(QDR_KPCA_Gauss(2,:),QDR_KPCA_Gauss(1,:),'b-');
hold on;
options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel_np3,Res,QDR_KPNS_NPoly_3] = kernel_pnsMain(transfusion,1,PGS,options);
plot(QDR_KPNS_NPoly_3(2,:),QDR_KPNS_NPoly_3(1,:),'y-');
hold on;
[ eigvec, eig_val, QDR_KPCA_NPoly_3 ] = kpca_main(transfusion,options);
plot(QDR_KPCA_NPoly_3(2,:),QDR_KPCA_NPoly_3(1,:),'g-');
R_kpca_3 = 100*eig_val/sum(eig_val);
hold on;

options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kernel_np5,Res,QDR_KPNS_NPoly_5] = kernel_pnsMain(transfusion,1,PGS,options);
plot(QDR_KPNS_NPoly_3(2,:),QDR_KPNS_NPoly_3(1,:),'m-');
hold on
[ eigvec, eig_val,QDR_KPCA_NPoly_3 ] = kpca_main(transfusion,options);
R_kpca_5 = 100*eig_val/sum(eig_val);
plot(QDR_KPCA_NPoly_3(2,:),QDR_KPCA_NPoly_3(1,:),'c-');
hold on
options.KernelType='Linear';
[ eigvec, eig_val,QDR_KPCA_linear ] = kpca_main(transfusion,options);
R_linear = 100*eig_val/sum(eig_val);
plot(QDR_KPCA_linear(2,:),QDR_KPCA_linear(1,:),'k-');
xlabel('k-Neighbourhood');
ylabel('Quality of DR');
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA','Location', 'southeast')

options.KernelType='Polynomial';
options.degree=3;
[ eigvec, eig_val ] = kpca_main(transfusion,options);
R_kpca_3 = 100*eig_val/sum(eig_val);

options.KernelType='Polynomial';
options.degree=5;
[ eigvec, eig_val ] = kpca_main(transfusion,options);
R_kpca_5 = 100*eig_val/sum(eig_val);


Total_R = [R_kernel(1:4) R_kpca_gauss(1:4) R_kernel_np3(1:4) R_kernel_np5(1:4) R_kpca_np3(1:4) R_kpca_np5(1:4) R_kpca_3(1:4) R_kpca_5(1:4) R_linear(1:4)]