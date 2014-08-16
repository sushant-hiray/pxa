function [ S ] = generate_points( n,dim )
%Generates n points on a sphere with dimension dim

S = zeros(n,dim);
%size(S)
for i =1:n
    %size(rand(1,dim))
    %size(S(i))
    S(i,:) = rand(1,dim);
    S(i,:) = S(i,:)/norm(S(i,:));
end

