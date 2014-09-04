function [E] = compute_error(v)
global Data;
X = Data;
global r;
    
v = v/norm(v);
applyToGivenRow = @(func, matrix,u) @(row) func(matrix(row, :),u);
applyToRows = @(func, matrix,u) arrayfun(applyToGivenRow(func, matrix,u), 1:size(matrix,1) )';

myFunc =@normLog_map;
E = applyToRows(myFunc,X,v);

E = E -r;
E = norm(E)^2;
end

function z = normLog_map(b,c)
    z = norm(log_map(b,c));
end