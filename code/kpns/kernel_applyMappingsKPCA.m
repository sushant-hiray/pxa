function [PData]  = kernel_applyMappingsKPCA(KData,Mapping,G,iData)
    noOfProjections = size(Mapping,2);
    meanKD = mean(KData,2);
    KData = KData-meanKD(:,ones(1,size(KData,2)));
    PData = zeros(size(KData));
    NormsM = sqrt(diag(Mapping'*G*Mapping));
    NormsM = NormsM';
    NormsM = NormsM(ones(size(KData,2),1),:);
    Mapping = Mapping./NormsM;
    for i =1:noOfProjections
        v = Mapping(:,i);
        PNorms = v'*G*KData;
        vRep = v(:,ones(1,size(KData,2)));
        PNormsRep = PNorms(ones(size(KData,2),1),:);
        PData = PData  + PNormsRep.*vRep;
    end
end