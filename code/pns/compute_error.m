function [E] = compute_error(v)
%v must be column vector
assert(iscolumn(v),'[compute_error]: input V must be a column');
global Data;
X = Data;
global r;
v = v/norm(v);
E = cellfun(@(x)(normLog_map(x, v)), num2cell(X, 1));
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




function z = normLog_map(b,c)
    b;
    %b = cell2mat(b);
    z = norm(log_map(b,c));
end