function [X,Mapping ] =generate_data(dim,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    assert(dim>=2, 'dim has to be greater than 2')
    
    % generate Data for 2 dim
    
    X = randn(N,2);
    Y = sqrt(sum(X.^2,2)); 
    Y = repmat(Y,[1 2]);
    X = X./Y;
    
    % 2D data generated
    geoMean = geodesic_mean(X);
    d = dim -2;
    currentDim = 2;
    Mapping = [];
    currentMap.v = geoMean;
    currentMap.r = 0;
    Mapping = [Mapping currentMap];
    while(d >0)
        r =pi/2;
        v = randn(1,currentDim+1);
        %v = [1 0 0]';
        v= v'/norm(v);
        e = zeros(currentDim+1,1);
        e(currentDim+1) = 1;
        rotationMat = rot_m(e,v);
        %e and v are column vectors
        currentMap.v = v';
        currentMap.r =r;
        Mapping = [Mapping currentMap];
        radius = sin(r);
        radius = repmat(radius,N,currentDim);
        'works'
        X = X./radius;
        Y = repmat(cos(r),N,1);
        
        size(Y)
        X = [X Y];
        size(X);
        
        currentDim =currentDim +1;
        d = d -1;
        'Capital X';
        size(X)
        X = rotate_data(X,rotationMat)
    end
    
end

