function [ Y ] = project_all(normal_vec , angle , X  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    applyToGivenRow = @(func, matrix,v,r) @(row) func(v,r,matrix(row, :));
    applyToRows = @(func, matrix,v,r) arrayfun(applyToGivenRow(func, matrix,v,r), 1:size(matrix,1), 'UniformOutput', false)';
    myFunc =@projection;
    Y    = applyToRows(myFunc,X,normal_vec,angle);
    Y = cell2mat(Y);
end

