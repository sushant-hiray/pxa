function [ V ] = pns( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    [v1 r1]=  applyLM(X);
    
    %project data on to the surface
    
    X1 = project_all(v1,r1,X);
    X2 = fk_all(v1,r1,X);
    
    %now apply the next iteration
    
    
    
end

