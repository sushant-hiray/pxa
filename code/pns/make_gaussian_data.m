function [ X ] = make_gaussian_data
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    X = mvnrnd(mu,SIGMA,n);
    size(X)
    X = normc(X');
    size(X)
end

