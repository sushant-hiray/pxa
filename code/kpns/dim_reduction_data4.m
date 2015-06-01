function [Total_R] = dim_reduction_data4(Data,name,maxDims,loadData,sampleNo)
close all;
%Removing unique 
%scalingFactor = sqrt (mean ( (abs(Data(:))).^2 ))
%scalingFactor = 1
%Data = Data / scalingFactor;
%RoundedData = roundn(Data,-4);
%Data = unique(RounddData','rows')';
%Data = Data * scalingFactor;

if nargin <=4
    sampleNo=0;
end

PGS =1;
loadData =0;
QRcriteria = 1; 

QRmaxDims =1;
filePath = strcat('../images/' , name);
if(loadData==0) 
    mkdir(filePath)
    filePath = strcat(strcat(filePath,'/'), strcat(name,int2str(sampleNo)));
    options.maxDims =QRmaxDims;

    options.KernelType='Gaussian';
    options.sigma = getSigma(Data)*0.7;
    options.degree=8;

    [Mapping_KPNS_Gauss,BkGm,R_kpns_gauss,Res,QDR_KPNS_Gauss,G_KPNS_Gauss] = kernel_pnsMain(Data,1,PGS,options);


    [eigvec_gauss, eig_val,QDR_KPCA_Gauss,G_KPCA_Gauss] = kpca_main(Data,options);
    R_kpca_gauss = 100*eig_val/sum(eig_val);

    options.KernelType = 'NPolynomial'
    options.degree = 4;

    
    [Mapping_KPNS_NPoly_5,BkGm,R_kpns_np5,Res,QDR_KPNS_NPoly_5,G_KPNS_NPoly_5] = kernel_pnsMain(Data,1,PGS,options);

    [ eigvec_npoly, eig_val,QDR_KPCA_NPoly_5,G_KPCA_NPoly_5] = kpca_main(Data,options);
    R_kpca_np5 = 100*eig_val/sum(eig_val);


    options.KernelType='Linear';
    [ eigvec_linear, eig_val,QDR_KPCA_linear,G_linear ] = kpca_main(Data,options);
    R_linear = 100*eig_val/sum(eig_val);
    save(strcat(filePath,'.mat'));
else
    filePath = strcat(strcat(filePath,'/'), strcat(name,int2str(sampleNo)));
    load(strcat(filePath,'.mat'));
end

% get the min dim for which the criteria of 95% is satisfied
minDim = min ([size(R_kpns_gauss,1) size(R_kpca_gauss,1) size(R_kpns_np5,1) size(R_kpca_np5,1) size(R_linear,1) inf]);
Frac_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)];

FracCumSum = cumsum (Frac_R, 1);
percentage = 70
dimReduced = min (sum (FracCumSum < percentage) + 1)
%dimReduced = 2
fractionalVarianceCaptureInReducedDim = FracCumSum (dimReduced,:)
'-------------------------------------'


if(QRcriteria ==1)
    options.maxDims = dimReduced;
    options.maxDims
else
    options.maxDims = dimReduced;   
    options.maxDims
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
    imagePath = strcat(imagePath,strcat(strcat('_',int2str(percentage))));
end
%imagePath = strcat(imagePath,strcat('_',int2str(sampleNo)));
title(name,'FontSize',14);
xlabel('k-Neighbourhood','FontSize',14);
ylabel('Quality of DR','FontSize',14);
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly5','KPCA-NPoly5','PCA','PNS','Location', 'southeast')
axis([1,size(Data,2),0,1.1])
set(gcf, 'Color', 'w');
% set(findall(gcf,'type','text'),'fontSize',14);
export_fig(imagePath,'-nocrop', '-painters','-m2', '-png');


minDim = min([size(R_kpns_gauss,1) size(R_kpca_gauss,1) size(R_kpns_np5,1) size(R_kpca_np5,1) size(R_linear,1) 10]);
Total_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)]


end
