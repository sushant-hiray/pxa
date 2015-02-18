function [var] = computeLevelVar(Data,GM)
    TData = log_map(GM,Data);
    var = sum(sum(TData.^2,1))/size(Data,2);
end