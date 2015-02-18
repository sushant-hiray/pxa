function [error] = residualVecGM(Data,v)
    
    MappedData = log_map(v,Data);
    temp = MappedData.^2;
    temp = sum(temp,1);
    temp = sqrt(temp);
    [m,i] = max(temp);
    ref = MappedData(:,i);
    signs = ref'*MappedData;
    signs = (signs>0)*1 + (signs<0)*(-1)
    error =temp.*signs;
	
end