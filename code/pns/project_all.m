function [ Y ] = project_all(normal_vec , angle , X  )
%normal_vec : column
%angle : scalar
%X: column

    assert(iscolumn(normal_vec), '[project_all]: normal_vec should be column');
    assert(iscolumn(X), '[project_all]: X should be column');
    
%     applyToGivenRow = @(func, matrix,v,r) @(row) func(v,r,matrix(row, :));
%     applyToRows = @(func, matrix,v,r) arrayfun(applyToGivenRow(func, matrix,v,r), 1:size(matrix,1), 'UniformOutput', false)';
%     myFunc =@projection;
%     Y    = applyToRows(myFunc,X,normal_vec,angle);
    
    Y = cellfun(@(x)(projection(normal_vec, angle, x)), num2cell(X, 1), 'UniformOutput', false);
    Y = cell2mat(Y);
end

