function [PData]  = kernel_applyMappings(KData,Mapping,G)
    noOfProjections= size(Mapping);
    PData = KData;
    for i =1:noOfProjections
        v0 = Mapping(i).v;
        %Find component perp to
        num_feat = size(PData,1);
        num_points = size(PData,2);
        perp = v0'*G*PData;
        perpComp = v0*perp;

        %Subtract the component
        PData = PData-perpComp;
        % scale data to fit on the sphere
        pNorm = sqrt(diag(PData'*G*PData)');
        pNormRep = pNorm(ones(num_feat,1),:);
        PData = PData./pNormRep; 
    end
end