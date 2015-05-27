function [Total_R] = dim_reduction_data(Data,name,maxDims)
PGS =1;
global criteria;
criteria = 1
options.KernelType='Gaussian';
options.degree=3;
options.maxDims =maxDims;
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
linewidth = 4;
plot(QDR_KPNS_Gauss(2,:),QDR_KPNS_Gauss(1,:),'r-','LineWidth',linewidth);
hold on;
plot(QDR_KPCA_Gauss(2,:),QDR_KPCA_Gauss(1,:),'b-','LineWidth',linewidth);
hold on;
plot(QDR_KPNS_NPoly_3(2,:),QDR_KPNS_NPoly_3(1,:),'y-','LineWidth',linewidth);
hold on;
plot(QDR_KPCA_NPoly_3(2,:),QDR_KPCA_NPoly_3(1,:),'g-','LineWidth',linewidth);
hold on;
plot(QDR_KPNS_NPoly_5(2,:),QDR_KPNS_NPoly_5(1,:),'m-','LineWidth',linewidth);
hold on
plot(QDR_KPCA_NPoly_5(2,:),QDR_KPCA_NPoly_5(1,:),'c-','LineWidth',linewidth);
hold on
plot(QDR_KPCA_linear(2,:),QDR_KPCA_linear(1,:),'k-','LineWidth',linewidth);
%%%%%%%%%%%%%%%
filePath = strcat('../images/' , name);
title(name,'FontSize',14);
xlabel('k-Neighbourhood','FontSize',14);
ylabel('Quality of DR','FontSize',14);
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA','Location', 'southeast')
axis([1,size(Data,2),0,1.1])
set(gcf, 'Color', 'w');
% set(findall(gcf,'type','text'),'fontSize',14);
export_fig(filePath,'-nocrop', '-painters','-m2', '-png');


% http://stackoverflow.com/questions/3546756/how-do-i-save-a-matrix-of-integers-to-a-text-file-in-matlab

dlmwrite(strcat(filePath, 'QDR_KPNS_QUASS.txt'), QDR_KPNS_Gauss(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_Gauss.txt'), QDR_KPCA_Gauss(1,:));
dlmwrite(strcat(filePath, 'QDR_KPNS_NPoly_3.txt'), QDR_KPNS_NPoly_3(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_NPoly_3.txt'), QDR_KPCA_NPoly_3(1,:));
dlmwrite(strcat(filePath, 'QDR_KPNS_NPoly_5.txt'), QDR_KPNS_NPoly_5(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_NPoly_5.txt'), QDR_KPCA_NPoly_5(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_linear.txt'), QDR_KPCA_linear(1,:));


minDim = min([size(R_kpns_gauss,1) size(R_kpca_gauss,1) size(R_kpns_np3,1) size(R_kpns_np5,1) size(R_kpca_np3,1) size(R_kpca_np5,1) size(R_linear,1) 10]);
Total_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np3(1:minDim)  R_kpca_np3(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)];

end