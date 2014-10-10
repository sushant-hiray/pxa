function [ var ] = compute_variances(X_2,gm,Mapping)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    size(X_2)
    size(Mapping)

    X_k = backProject(X_2,Mapping);
    gm_back = backProject(gm,Mapping);
    
    no_of_samples = size(X_2,2);
    tangentSpace_X = cellfun(@(x)(normLog_map(x,gm_back)), num2cell(X_k, 1), 'UniformOutput', false);
    tangentSpace_X = cell2mat(tangentSpace_X);
    var = norm(tangentSpace_X)/no_of_samples;
    
end


function z = normLog_map(point,v)
    size(point);
    %size(normal)
    norm(point);
    
    p1 = log_map(v,point);
    %b = cell2mat(b);
    z = norm(p1);
    
end