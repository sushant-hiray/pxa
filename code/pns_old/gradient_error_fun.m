function [G] = gradient_error_fun(v)
%v must be column vector
% if v = 0 vec then compute_error is actual error.
assert(iscolumn(v),'[compute_error]: input V must be a column');
global v0;
global Data;
X = Data;
global r;
X = cellfun(@(x)(log_map(v0,x)), num2cell(X, 1),'UniformOutput',false);
X = cell2mat(X);
Temp = repmat(v,1,size(X,2));
%sigma -2(||xi - v|| -r)(xi-v)/|xi-r|
Temp2 = -normc(X - Temp);

G = X-Temp;
norm_mat  = sqrt(sum (G.^2 , 1)) -r;
norm_mat = repmat(norm_mat,size(X,1),1);
G = Temp2.*norm_mat;
G = sum(G,2);
end
