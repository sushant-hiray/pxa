function [data ] = generate_triangles(nTriangles,noise)
    


    X = [-1 1 0]'
    Ydummy = 0.5*ones(1,nTriangles)+abs(randn(1,nTriangles));
    Y = [0 0]'
    X = X(:,ones(1,nTriangles));
    Y = Y(:,ones(1,nTriangles));
    Y = [Y;Ydummy];
    Y = [Y(1,:) - Ydummy/3;Y(2,:) - Ydummy/3; 2*Ydummy/3]
    if(noise)
        X = X + 0.2*randn(size(X));
        Y = Y + 0.2*randn(size(Y));
    end
    meanX = mean(X,1);
    X = X -  meanX(ones(1,size(X,1)),:);
    meanY = mean(Y,1);
    Y = Y -  meanY(ones(1,size(Y,1)),:);
    
    
    data = [X;Y];
    data = normc(data);
    sum(data,2);
    sum(data.^2);
    pause
end