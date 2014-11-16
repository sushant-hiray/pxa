function [data ] = generate_triangles(nTriangles)
    


    X = [-1 1 0]'
    Ydummy = 0.5+abs(randn(1,nTriangles));
    Y = [0 0]'
    X = X(:,ones(1,nTriangles));
    Y = Y(:,ones(1,nTriangles));
    Y = [Y;Ydummy];
    Y = [Y(1,:) - Ydummy/3;Y(2,:) - Ydummy/3; 2*Ydummy/3]
    X = X + 0.05*randn(size(X));
    Y = Y + 0.05*randn(size(Y));
    data = [X;Y];
    data = normc(data);
end