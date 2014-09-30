function [ Y ] = fk_all( vk , rk , X )
assert(isscalar(rk), '[fk_all]:rk sould be scalar');
assert(iscolumn(vk), '[fk_all]: vk should be column vector');

%rotates all the points to north pole.
%     applyToGivenRow = @(func, matrix,v,r) @(row) func(v',r,matrix(row, :)');
%     applyToRows = @(func, matrix,v,r) arrayfun(applyToGivenRow(func, matrix,v,r), 1:size(matrix,1), 'UniformOutput', false)';
%     myFunc =@fk;
%     Y    = applyToRows(myFunc,X,vk,rk);
%     Y = cell2mat(Y);

Y = cellfun(@(x)(fk(vk, rk, x)), num2cell(X, 1), 'UniformOutput', false);
Y = cell2mat(Y);
end

