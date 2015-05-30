function [Total_R] = dim_reduction_data2(Data,name,maxDims,loadData)
PGS =1;
loadData =1;
global QRcriteria;
QRcriteria = 0; 
close all;
QRmaxDims =1;
filePath = strcat('../images/' , name);
percentage =80;
if(loadData==0) 
    mkdir(filePath)
    filePath = strcat(strcat(filePath,'/'), name);
     options.maxDims =QRmaxDims;

    options.KernelType='Gaussian';
    options.degree=3;

    [Mapping_KPNS_Gauss,BkGm,R_kpns_gauss,Res,QDR_KPNS_Gauss,G_KPNS_Gauss] = kernel_pnsMain(Data,1,PGS,options);


    [eigvec_gauss, eig_val,QDR_KPCA_Gauss,G_KPCA_Gauss] = kpca_main(Data,options);
    R_kpca_gauss = 100*eig_val/sum(eig_val);

    options.KernelType='NPolynomial';
    options.degree=5;
    [Mapping_KPNS_NPoly_5,BkGm,R_kpns_np5,Res,QDR_KPNS_NPoly_5,G_KPNS_NPoly_5] = kernel_pnsMain(Data,1,PGS,options);

    [ eigvec_npoly, eig_val,QDR_KPCA_NPoly_5,G_KPCA_NPoly_5] = kpca_main(Data,options);
    R_kpca_np5 = 100*eig_val/sum(eig_val);


    options.KernelType='Linear';
    [ eigvec_linear, eig_val,QDR_KPCA_linear,G_linear ] = kpca_main(Data,options);
    R_linear = 100*eig_val/sum(eig_val);
    save(strcat(filePath,'.mat'));
else
    filePath = strcat(strcat(filePath,'/'), name);
    load(strcat(filePath,'.mat'));
end

% get the min dim for which the criteria of 95% is satisfied
dim95 = zeros(1,5);
minDim = min([size(R_kpns_gauss,1) size(R_kpca_gauss,1) size(R_kpns_np5,1) size(R_kpca_np5,1) size(R_linear,1) 10]);
Total_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)];

if(QRcriteria==1)
    for i=1:5
        totalVar =0;
        while((totalVar <= percentage ) )
            if(dim95(i)<size(Total_R(:,i),1))
                dim95(i) = dim95(i) + 1;
                totalVar = totalVar + Total_R(dim95(i),i);
            else
                break;
            end
        end
    end
end

if(QRcriteria ==1)
    options.maxDims = min(dim95);
    '95% dim'
    options.maxDims
else
    QRmaxDims =1;
    options.maxDims = QRmaxDims;
end

QDR_KPNS_Gauss  = estimateQualityDR    (Data,eye(size(Data,2)),G_KPNS_Gauss,Mapping_KPNS_Gauss,R_kpns_gauss,options.maxDims);
QDR_KPCA_Gauss  = estimateQualityDRKPCA(Data,eye(size(Data,2)),G_KPCA_Gauss,eigvec_gauss,R_kpca_gauss,options.maxDims);
QDR_KPNS_NPoly_5  = estimateQualityDR  (Data,eye(size(Data,2)),G_KPNS_NPoly_5,Mapping_KPNS_NPoly_5,R_kpns_np5,options.maxDims);
QDR_KPCA_NPoly_5= estimateQualityDRKPCA(Data,eye(size(Data,2)),G_KPCA_NPoly_5,eigvec_npoly,R_kpca_np5,options.maxDims);
QDR_KPCA_linear = estimateQualityDRKPCA(Data,eye(size(Data,2)),G_linear,eigvec_linear,R_linear,options.maxDims);


xAxis = 1:size(Data,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth = 4;
plot(xAxis,QDR_KPNS_Gauss(1,:),'r-','LineWidth',linewidth);
hold on;
plot(xAxis,QDR_KPCA_Gauss(1,:),'b-','LineWidth',linewidth);
hold on;
plot(xAxis,QDR_KPNS_NPoly_5(1,:),'m-','LineWidth',linewidth);
hold on
plot(xAxis,QDR_KPCA_NPoly_5(1,:),'c-','LineWidth',linewidth);
hold on
plot(xAxis,QDR_KPCA_linear(1,:),'k-','LineWidth',linewidth);

%%%%%%%%%%%%%%%
imagePath = strcat(filePath,strcat('_',strcat(int2str(QRcriteria),strcat('_',int2str(options.maxDims)))));
if(QRcriteria ==1)
    imagePath = strcat(imagePath,strcat('_',int2str(percentage)));
end
title(name,'FontSize',14);
xlabel('k-Neighbourhood','FontSize',14);
ylabel('Quality of DR','FontSize',14);
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly5','KPCA-NPoly5','PCA','PNS','Location', 'southeast')
axis([1,size(Data,2),0,1.1])
set(gcf, 'Color', 'w');
% set(findall(gcf,'type','text'),'fontSize',14);
export_fig(imagePath,'-nocrop', '-painters','-m2', '-png');


% http://stackoverflow.com/questions/3546756/how-do-i-save-a-matrix-of-integers-to-a-text-file-in-matlab

dlmwrite(strcat(filePath, 'QDR_KPNS_QUASS.txt'), QDR_KPNS_Gauss(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_Gauss.txt'), QDR_KPCA_Gauss(1,:));
dlmwrite(strcat(filePath, 'QDR_KPNS_NPoly_5.txt'), QDR_KPNS_NPoly_5(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_NPoly_5.txt'), QDR_KPCA_NPoly_5(1,:));
dlmwrite(strcat(filePath, 'QDR_KPCA_linear.txt'), QDR_KPCA_linear(1,:));


minDim = min([size(R_kpns_gauss,1) size(R_kpca_gauss,1) size(R_kpns_np5,1) size(R_kpca_np5,1) size(R_linear,1) 10]);
Total_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)];
end