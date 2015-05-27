function QDR= estimateQualityDRKPCA(iData,KernelFeatureSpaceData,G,EigVec,Variances,noOfDims)
    global criteria
    % iData: The data in input feature space
    % kernelFeatureSpaceData: The Data in Kerenl Feature 
    % G = Gram Matrix
    % Mapping: Directions of projections
    % Variances: The % Variance covered along that dimension
    % noOfDims: The depth of projection
    N = size(iData,2);
    etaMatrix = zeros(N,N); % this will have all the distance ranking in inputSpace
    muMatrix = zeros(N,N); % this will have distance rankings in kernel Space
    dMatrix = zeros(N,N);
    rhoMatrix = zeros(N,N);
    
    %Fill in dMatrix
    for i=1:N
        for j=1:i
            temp = iData(:,i) -iData(:,j);  
            dMatrix(i,j) = sqrt(temp'*temp);
        end
    end
    dMatrix = max(dMatrix,dMatrix');
    %ProjectData along all the dimensions on Mappings. Choose a threshold
    %1E-5 after which you will stop projections
    FilteredMapping = [];
%     for i=1:size(EigVec,2)
%         if(Variances(i) > 1E-5)
%             FilteredMapping = [FilteredMapping EigVec(:,i)];
%         else
%             break;
%         end
%     end
%     for i=1:noOfDims
%         if(Variances(i) > 1E-5)
%             FilteredMapping = [FilteredMapping EigVec(:,i)];
%         else
%             break;
%         end
%     end
    
   if(criteria ==1)
        for i=1:noOfDims
             FilteredMapping = [FilteredMapping EigVec(:,i)];
        end
    else
        totalVar = 0;
        for i=1:size(EigVec,2)
           if(totalVar > 95)
                break;
           end
           FilteredMapping = [FilteredMapping EigVec(:,i)];
           totalVar = totalVar + Variances(i);
        end
    end
    
    
    ProjectedData = kernel_applyMappingsKPCA(KernelFeatureSpaceData,FilteredMapping,G,iData);
    for i=1:N
        for j=1:i
            temp = ProjectedData(:,i) - ProjectedData(:,j);
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
    
    CoRankMat = zeros(N,N);
    
    for i=1:N
        for j=1:N
            CoRankMat(etaMatrix(i,j), muMatrix(i,j)) = CoRankMat(etaMatrix(i,j), muMatrix(i,j))+1;
        end
    end
    
    FK = zeros(1,N);
    FK(1) = CoRankMat(1,1);
    for i =2:N
       FK(i)= FK(i-1);
       for j=1:i
            FK(i) =FK(i)  + CoRankMat(i,j) + CoRankMat(j,i);
       end
       FK(i) = FK(i) -CoRankMat(i,i);
    end
        
    Ks = N*(1:N);
    FK = FK./Ks;
%    plot(1:N,FK,'r-');
    QDR= FK;
end