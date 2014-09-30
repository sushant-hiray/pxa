function [X,Mapping] = generate_data2(dim,N)
% Generates N data points in given dimension
    
    %dim >= 2
    assert(dim>=2, 'dim has to be greater than 2')    
    
    % generate Data for 2 dim
    X = abs(randn(2,N));   %2xN matrix
    Y = sqrt(sum(X.^2,2)); 
    Y = repmat(Y,[1 2]);
    X = normc(X);
    % 2D data generated
    
    
    geoMean = geodesic_mean(X);
    d = dim - 2; %dim is reduced by 2 as our base dim is 2.
                 %so we need only dim - 2 iterations
    currentDim = 2;
    % Holds the mapping of data. i.e v and r
    % TODO: preallocate the size to Mapping
    Mapping = [];
    currentMap.v = geoMean;
    currentMap.r = 0;
    Mapping = [Mapping currentMap];
    sigmaNoise = 0.05; %noise is added as the data is not 
                       %exactly k dim without it. it remains 2 dimensional
    
    while(d >0)
        r = pi/2;
        
        v = randn(1,currentDim+1);
        v= v'/norm(v); %col vector (v is a random point in currentDim + 1)
        
        e = zeros(currentDim+1,1); %col vector
        e(currentDim+1) = 1; % e is [0 0. . .0 1]'
        
        
        rotationMat = rot_m(e, v); %matrix of dim [currentDim+1 x currentDim+1]
                                   %rotates v to e
        
        currentMap.v = v; % currentMap stores v as row
        currentMap.r = r;
        Mapping = [Mapping currentMap]; %append currentMap
        
        radius = sin(r);
        %radius = repmat(radius,N,currentDim); %row vector [1 1 1] of dim currentDim
                                              %corresponding to each
                                              %matrix dim: [NxcurrentDim]
        
        
        X = X/radius; %row Vector corresponding to each n
        
        Y = repmat(cos(r),1,N); %col vector of size N
        %Y  = Y + abs(sigmaNoise*randn(1,N));
        X = [X;Y];
        X = normc(X); %normalize the matrix X over its cols.
                       
        %while loop post processing        
        currentDim = currentDim +1;
        d = d - 1;
        X = rotate_data(X,rotationMat); %rotate the points via rotationMatrix
                                        %formed using e and v
    end
    
end

