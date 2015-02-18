function [ X ] = genData(v,r,n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    dim =size(v);
    dim = dim(2);
    X = zeros(n,dim);
    
    for i=1:n
        X(i,dim) = cos(r);
        rest = rand(1,dim-1)-0.5    ;
        rest = rest';
        rest = (sin(r)/norm(rest))*rest;
        X(i,1:dim-1) = rest;
    end
    X = normc(X);
end

