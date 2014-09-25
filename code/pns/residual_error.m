function [ err ] = residual_error(X, v, r, r_prod)
% returns the residual error pho(x,v) -r for all n points in a row vector

%v must be column vector
assert(iscolumn(v),'[residual_error]: input V must be a column');
E = cellfun(@(x)(res_single(x, v, r)), num2cell(X, 1));
err = r_prod*E;
end

function [a] = res_single(x, v, r)

t1 = acos(dot(x,v));
a = r - t1;
end

