function [Total_R] = dim_reduction_data(Data,name)
PGS =1;
options.KernelType='Gaussian';
options.degree=3;
[Mapping,BkGm,R_kpns_gauss,Res,QDR_KPNS_Gauss] = kernel_pnsMain(Data,1,PGS,options);
[ eigvec, eig_val,QDR_KPCA_Gauss ] = kpca_main(Data,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kpns_np3,Res,QDR_KPNS_NPoly_3] = kernel_pnsMain(Data,1,PGS,options);

[ eigvec, eig_val, QDR_KPCA_NPoly_3 ] = kpca_main(Data,options);
R_kpca_np3 = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kpns_np5,Res,QDR_KPNS_NPoly_5] = kernel_pnsMain(Data,1,PGS,options);

[ eigvec, eig_val,QDR_KPCA_NPoly_5 ] = kpca_main(Data,options);
R_kpca_np5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val,QDR_KPCA_linear ] = kpca_main(Data,options);
R_linear = 100*eig_val/sum(eig_val);


%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=figure();
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
filePath = strcat('../images/' , name);
title(name)
xlabel('k-Neighbourhood');
ylabel('Quality of DR');
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA','Location', 'southeast')
axis([1,size(Data,2),0,1.1]) 
saveas(f,filePath,'png');
minDim = min([size(R_kpns_gauss,1) size(R_kpca_gauss,1) size(R_kpns_np3,1) size(R_kpns_np5,1) size(R_kpca_np3,1) size(R_kpca_np5,1) size(R_linear,1) 10]);

Total_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np3(1:minDim)  R_kpca_np3(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)];

end