function [ Y ] = rotate_data(X,r)
%     % rotate data of X via the rotation matrix r
%     applyToGivenRow = @(func, matrix,r) @(row) func(matrix(row, :)',r);
%     applyToRows = @(func, matrix,r) arrayfun(applyToGivenRow(func, matrix,r), 1:size(matrix,1), 'UniformOutput', false)';
%     myFunc = @rotate_x;
%     Y = applyToRows(myFunc,X,r);
%     Y = cell2mat(Y);


Y = cellfun(@(x)(rotate_x(x,r)), num2cell(X, 1), 'UniformOutput', false);
Y = cell2mat(Y);
end

function [y] = rotate_x(x,r)
    % x is column vector
    y = r*x;
end

