function [QDRs,maxDims] = getQDR(PathToMatFile)
load(PathToMatFile);
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

QDRs = zeros(size(Data,2),5);
QDRs(:,1)  = estimateQualityDR    (Data,eye(size(Data,2)),G_KPNS_Gauss,Mapping_KPNS_Gauss,R_kpns_gauss,options.maxDims);
QDRs(:,2)  = estimateQualityDRKPCA(Data,eye(size(Data,2)),G_KPCA_Gauss,eigvec_gauss,R_kpca_gauss,options.maxDims);
QDRs(:,3)  = estimateQualityDR  (Data,eye(size(Data,2)),G_KPNS_NPoly_5,Mapping_KPNS_NPoly_5,R_kpns_np5,options.maxDims);
QDRs(:,4)= estimateQualityDRKPCA(Data,eye(size(Data,2)),G_KPCA_NPoly_5,eigvec_npoly,R_kpca_np5,options.maxDims);
QDRs(:,5) = estimateQualityDRKPCA(Data,eye(size(Data,2)),G_linear,eigvec_linear,R_linear,options.maxDims);
maxDims = options.maxDims;
end