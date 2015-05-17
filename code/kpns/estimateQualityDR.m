function estimateQualityDR(iData,KernelFeatureSpaceData,G,Mappings,Variances,noOfDims)
    % iData: The data in input feature space
    % kernelFeatureSpaceData: The Data in Kerenl Feature 
    % G = Gram Matrix
    % Mapping: Directions of projections
    % Variances: The % Variance covered along that dimension
    % noOfDims: The depth of projection
    N = size(iData,2);
    etaMatrix = zeros(N,N) % this will have all the distance ranking in inputSpace
    muMatrix = zeros(N,N) % this will have distance rankings in kernel Space
    dMatrix = zeros(N,N)
    rhoMatrix = zeros(N,N)
    
    %Fill in dMatrix
    for i=1:N
        for j=1:i
            temp = iData(:,i) -iData(:,j);
            dMatrix(i,j) = sqrt(temp'*terp);
        end
    end
    dMatrix = max(dMatrix,dMatrix');
    %ProjectData along all the dimensions on Mappings. Choose a threshold
    %1E-5 after which you will stop projections
    FilteredMapping = []
    for i=1:size(Mapping)
        if(Variances(i) > 1E-5)
            FilteredMapping = [FilteredMapping Mapping(i)];
        else
            break;
        end
    end
    ProjectedData = kernel_applyMappings(KernelFeatureSpaceData,FilteredMapping,G);
    for i=1:N
        for j=1:i
            temp = ProjectedData(:,i) - ProjectedData(:,j);s
            rhoMatrix(i,j) = sqrt(temp'*G*temp);
        end
    end
    rhoMatrix = max(rhoMatrix,rhoMatrix');
    
    for i =1:N
        [X,Y] = sort(dMatrix(i,:));
        for j=1:N
            etaMatrix(i,Y(j)) = j;
        end
    end
    
    for i =1:N
        [X,Y] = sort(rhoMatrix(i,:));
        for j=1:N
            muMatrix(i,Y(j)) = j;
        end
    end
    
    CoVarMat = zeros(N,N);
    
    for i=1:N
        for j=1:N
            CoVarMat(etaMatrix(i,j), muMatrix(i,j)) = CoVarMat(etaMatrix(i,j), muMatrix(i,j))+1
        end
    end
    
end