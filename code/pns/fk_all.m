function [ Y ] = fk_all( vk , rk , X )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    applyToGivenRow = @(func, matrix,v,r) @(row) func(v',r,matrix(row, :)');
    applyToRows = @(func, matrix,v,r) arrayfun(applyToGivenRow(func, matrix,v,r), 1:size(matrix,1), 'UniformOutput', false)';
    myFunc =@fk;
    Y    = applyToRows(myFunc,X,vk,rk);
    Y = cell2mat(Y);

end

