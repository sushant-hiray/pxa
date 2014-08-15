function [ S ] = generate_points( n,dim )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

S = zeros(n,dim);
%size(S)
for i =1:n
    %size(rand(1,dim))
    %size(S(i))
    S(i,:) = rand(1,dim);
    S(i,:) = S(i,:)/norm(S(i,:));
end

