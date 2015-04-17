function [pData] = kernel_projectData(G,KData,Mapping)
    v0 = Mapping.v;
    %Find component perp to
    num_feat = size(KData,1);
    num_points = size(KData,2);
    perp = v0'*G*KData;
    perpComp = v0*perp;
    
    %Subtract the component
    pData = KData-perpComp;
    % scale data to fit on the sphere
    pNorm = sqrt(diag(pData'*G*pData)');
    pNormRep = pNorm(ones(num_feat,1),:);
    pData = pData./pNormRep;
end