function QDR= estimateQualityDR(iData,KernelFeatureSpaceData,G,Mapping,Variances,noOfDims)
    global criteria;
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
%     for i=1:size(Mapping)
%         if(Variances(i) > 1E-5)
%             FilteredMapping = [FilteredMapping Mapping(i)];
%         else
%             break;
%         end
%     end

    if(criteria ==1)
        finalDim = noOfDims;
        
    else
        totalVar = 0;
        finalDim = 1;
        for i=1:size(Mapping,2)
           if(totalVar > 95)
                break;
           end
           totalVar = totalVar + Variances(i);
           finalDim = finalDim+1;
        end
    end
    
    for i = 1:(size(Mapping,2) - finalDim)
        FilteredMapping = [FilteredMapping Mapping(i)];
    end    
           
    
    ProjectedData = kernel_applyMappings(KernelFeatureSpaceData,FilteredMapping,G);
    
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
    CummulativeN = zeros(N,1);
    CummulativeX = zeros(N,1);
    CummulativeD = zeros(N,1); 
    CummulativeD(1) = 1;
    for i=2:N
        CummulativeX(i) = CummulativeX(i-1);
        CummulativeN(i) = CummulativeN(i-1);
        CummulativeD(i) = CummulativeD(i-1)+CoRankMat(i,i);
        for j=1:i
            CummulativeN(i) = CummulativeN(i) + CoRankMat(j,i);
        end
        for k=1:i
            CummulativeX(i) = CummulativeX(i) + CoRankMat(i,j);
        end
    end
    Q= zeros(N,1);
    Q = CummulativeN + CummulativeX + CummulativeD;
    for i=1:N
        Q(i) = Q(i)/(i*N);
    end

    Wn = zeros(N,1); 
    Wv = zeros(N,1);
    Hk = zeros(N,1);
    i =1;
    for j=1:N
            Wn(i) = Wn(i)  + (abs(j-i)/i)*CoRankMat(i,j);
            Wv(i) = Wv(i) + (abs(i-j)/j)*CoRankMat(i,j);
    end
    Hk(i) = abs(N-2*i)/i;
    for i =2:N
        Wn(i) = Wn(i-1);
        Wv(i) = Wv(i-1);
        for j=1:N
            Wn(i) = Wn(i)  + (abs(j-i)/i)*CoRankMat(i,j);
            Wv(i) = Wv(i) + (abs(i-j)/j)*CoRankMat(i,j);
        end
        Hk(i) = Hk(i-1) + abs(N-2*i)/i
    end
    Hk = N*Hk;
    Wn = Wn./Hk;
    Wv = Wv./Hk;

    Ulc = zeros(1,N);
    i =1;
    Ulc(i) = CoRankMat(i,i);
    for i=2:N
        for j=1:i
            Ulc(i) = Ulc(i) + CoRankMat(i,j) + CoRankMat(j,i);
        end
    end
    Temp = 1:N;
    Temp1 = N*Temp;
    Temp2 = Temp/(1-N);
    Ulc = Ulc./Temp1 + Temp2;
    
    

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
    QDR=FK
%    plot(1:N,FK,'r-');
end