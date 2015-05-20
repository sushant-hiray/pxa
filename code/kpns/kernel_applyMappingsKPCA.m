function [PData]  = kernel_applyMappingsKPCA(KData,Mapping,G)
    noOfProjections = size(Mapping,2);
    meanKD = mean(KData,2);
    KData = KData-meanKD(:,ones(1,size(KData,2)));
    PData = zeros(size(KData));
    for i =1:noOfProjections
        v = Mapping(:,i);
        PNorms = v'*G*KData/(v'*G*v);
        vRep = v(:,ones(1,size(KData,2)));
        PNormsRep = PNorms(ones(size(KData,2),1),:);
        PData = PData  + PNormsRep.*vRep;
    end
end