function [ var ] = compute_variances(X,gm,Mapping)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


modes= size(Mapping,2)
X_new = X;
for i=1:modes
    v = Mapping(i).v
    r = Mapping(i).r
    X_temp = project_all(v,r,X_new);
    
    X_new = fk_all(v,r,X_temp);
end
assert(size(X_new,1) ==size(gm,1), 'gm and data not in same subspace');
no_of_samples = size(X,2);

tangentSpace_X = cellfun(@(x)(normLog_map(x,gm)), num2cell(X_new, 1), 'UniformOutput', false);
tangentSpace_X = cell2mat(tangentSpace_X);
var = norm(tangentSpace_X)^2/no_of_samples;

end


function z = normLog_map(point,v)
size(point);
%size(normal)
norm(point);

p1 = log_map(v,point);
%b = cell2mat(b);
z = norm(p1);

end