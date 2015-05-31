function [Total_R] = dim_reduction_data3(Data,name,maxDims,loadData)
PGS =1;
global QRcriteria;
QRcriteria = 0; 
close all;
QRmaxDims =4;
filePath = strcat('../images/' , name);
options.maxDims = QRmaxDims;
if(loadData==0) 
    mkdir(filePath)
    filePath = strcat(strcat(filePath,'/'), name);
    options.KernelType='Linear';
    [ eigvec_linear, eig_val,QDR_KPCA_linear,G_linear ] = kpca_main(Data,options);
    R_linear = 100*eig_val/sum(eig_val);
   
    options.KernelType='Linear';
    options.degree=3;
    options.maxDims =QRmaxDims;
    [Mapping_KPNS_Linear,BkGm,R_kpns_Linear,Res,QDR_KPNS_Linear,G_KPNS_Linear] = kernel_pnsMain(Data,1,PGS,options);
    save(strcat(filePath,'.mat'));    
else
    filePath = strcat(strcat(filePath,'/'), name);
    load(strcat(filePath,'.mat'));
end

totalPlots  = 2;
% get the min dim for which the criteria of 95% is satisfied
dim95 = zeros(1,totalPlots);
minDim = min([size(R_linear,1) size(R_kpns_Linear,1) 10]);
%Total_R = [R_kpns_gauss(1:minDim) R_kpca_gauss(1:minDim) R_kpns_np5(1:minDim) R_kpca_np5(1:minDim) R_linear(1:minDim)];
Total_R = [R_linear(1:minDim) R_kpns_Linear(1:minDim)];

if(QRcriteria==1)
    for i=1:totalPlots
        totalVar =0;
        while((totalVar <= 95 ) )
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
    options.maxDims = QRmaxDims;
end

options.maxDims

QDR_KPCA_linear = estimateQualityDRKPCA(Data,eye(size(Data,2)),G_linear,eigvec_linear,R_linear,options.maxDims);
QDR_KPNS_Linear  = estimateQualityDR    (Data,eye(size(Data,2)),G_KPNS_Linear,Mapping_KPNS_Linear,R_kpns_Linear,options.maxDims);

linewidth = 4;
xAxis = 1:size(Data,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(xAxis,QDR_KPCA_linear(1,:),'k-','LineWidth',linewidth);
hold on
plot(xAxis,QDR_KPNS_Linear(1,:),'g-','LineWidth',linewidth);

%%%%%%%%%%%%%%%
imagePath = strcat(filePath,strcat('_',strcat(int2str(QRcriteria),strcat('_',int2str(options.maxDims)))));
if(QRcriteria ==1)
    imagePath = strcat(imagePath,'_95');
end
%title(name,'FontSize',14);
xlabel('k-Neighbourhood','FontSize',30);
ylabel('Quality of DR','FontSize',30);
legend('PCA','PNS','Location', 'southeast')
%axis([1,size(Data,2),0,1.1])
axis tight;
grid on;
set(gcf, 'Color', 'w');
% set(findall(gcf,'type','text'),'fontSize',14);
export_fig(imagePath,'-nocrop', '-painters','-m2', '-png');


% http://stackoverflow.com/questions/3546756/how-do-i-save-a-matrix-of-integers-to-a-text-file-in-matlab



minDim = min([size(R_linear,1) size(R_kpns_Linear,1) 10]);
Total_R = [R_linear(1:minDim) R_kpns_Linear(1:minDim)];
end