function [PData2,K_Center,BB]  = kernel_applyMappingsKPCA(KData,Mapping,G,iData)
    noOfProjections = size(Mapping,2);
    N = size(KData,2);
    TempMat1 = -ones(size(G))/N + eye(size(G));
    K_Center= TempMat1'*G*TempMat1;
    
    meanKD = mean(KData,2);
    KData = KData-meanKD(:,ones(1,size(KData,2)));
    
    NormsM = sqrt(diag(Mapping'*K_Center*Mapping));
    NormsM = NormsM';
    NormsM = NormsM(ones(size(KData,2),1),:);
    Mapping = Mapping./NormsM;
    
    
    PData  = Mapping'*K_Center*KData;
    
    PData2 = zeros(size(KData));
   
    for i =1:noOfProjections
        v = Mapping(:,i);
        PNorms = v'*K_Center*KData;
        vRep = v(:,ones(1,size(KData,2)));
        PNormsRep = PNorms(ones(size(KData,2),1),:);
        PData2 = PData2  + PNormsRep.*vRep;
    end
    %}
    meanID = mean(iData,2);
    BB = iData - meanID(:, ones(1,size(iData,2)));
    AA = BB*PData2;
    
    %PData2 = BB;
    
   
end