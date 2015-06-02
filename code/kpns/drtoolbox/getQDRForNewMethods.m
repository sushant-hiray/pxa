function [QDR] = getQDRForNewMethods(iData,ComputedCoordinates)
    N = size(iData,2);
    etaMatrix = zeros(N,N); % this will have all the distance ranking in inputSpace
    muMatrix = zeros(N,N); % this will have distance rankings in kernel Space
    dMatrix = zeros(N,N);   
    rhoMatrix = zeros(N,N);
     for i=1:N
        for j=1:i
            temp = iData(:,i) -iData(:,j);
            dMatrix(i,j) = sqrt(temp'*temp);
        end
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


end