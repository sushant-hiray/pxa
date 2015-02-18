function [pData] = projectOnSubSpace(Data,Map)
    phoxv = log_map(Map.v,Data);
    phoxv = phoxv.^2;
    phoxv = sqrt(sum(phoxv,1));
    phoxv = phoxv(ones(size(Data,1),1),:);
    v = Map.v;
    Vrep =v(:,ones(1,size(Data,2)));
	pData = (sin(Map.r)*Data + sin(phoxv - Map.r).*Vrep);
    pData = pData./sin(phoxv);
    
end