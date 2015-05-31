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

    finalDim = noOfDims;
    reduce_flag = 1;
    
    ProjectedData = KernelFeatureSpaceData;
    i = 1;
    gm = Mapping(end).v;
    
    ComputedCoordinates  = zeros(size(finalDim,size(KernelFeatureSpaceData,2)));
    
    while(reduce_flag ==1)
       
        TData = kernel_log_map(G,ProjectedData,gm);
        TG =TData'*G*TData;
        one_mat = ones(size(TG))./N;
        TG = TG - one_mat*TG - TG*one_mat + one_mat*TG*one_mat;
        [U S] = svd(TG);
        NormsU = sqrt(max(diag(U'*TG*U)', 1E-10));
        NormsU = (NormsU <1E-10)*1 + NormsU;
        NormsURep = NormsU(ones(size(U,1),1),:);
        UNormalized = U./NormsURep;
        'diag';
        diag(S(1:20,1:20))';
      
        finalDim;
        size(find(diag(S) > 1E-3 ) ,1);
        
        if(size(find(diag(S) > 1E-3 ) ,1) <= finalDim)
            reduce_flag =0;
            TempMat1 = -ones(size(TG))/N + eye(size(TG));
            
            ComputedCoordinates =UNormalized(:,1:finalDim)'*TG*eye(size(TG));
            break;
        end
        ProjectedData =  kernel_applyMappings(ProjectedData,Mapping(i),G);
        i = i+1;
    end
    
    
    
    
        
    for i=1:N
        for j=1:i
            temp = ComputedCoordinates(:,i) - ComputedCoordinates(:,j);
            rhoMatrix(i,j) = sqrt(temp'*temp);
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
    QDR=FK;
%    plot(1:N,FK,'r-');
end