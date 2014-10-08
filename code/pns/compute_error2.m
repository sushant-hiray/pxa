function [E] = compute_error2(v)
%v must be column vector
% if v = 0 vec then compute_error is actual error.
assert(iscolumn(v),'[compute_error]: input V must be a column');
global v0;
global Data;
X = Data;
global r;

E = cellfun(@(x)(normLog_map(x,v,v0)), num2cell(X, 1));
%E = cell2mat(E);
E = E - r;
E = norm(E)^2;
E = E/size(X,2); %normalizing by number of data points
end

% v = v/norm(v);
% applyToGivenRow = @(func, matrix,u) @(row) func(matrix(row, :),u);
% applyToRows = @(func, matrix,u) arrayfun(applyToGivenRow(func, matrix,u), 1:size(matrix,1) )';
% 
% myFunc =@normLog_map;
% E = applyToRows(myFunc,X,v);
% % residual = pho(x, v) - r
% E = E - r;
% E = norm(E)^2;
% E = E/size(X,1);




function z = normLog_map(point,v,v0)
    size(point);
    %size(normal)
    norm(point);
    
    p1 = log_map(v0,point);
    %b = cell2mat(b);
    z = norm(p1-v);
    
end