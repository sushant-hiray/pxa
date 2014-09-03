function [Mapping] = pns( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    data_dim = size(X,2);
    orignal_dim = data_dim;
    Mapping =[];
    V = zeros(0,orignal_dim);
    R =zeros(0,0);
    X_new = X;
    while data_dim > 2
        
        [v1 r1]=  applyLM(X_new);
        CurrMap.v = v1;
        CurrMap.r = r1;
        Mapping = [Mapping CurrMap];
        %project data on to the surface

        X_temp = project_all(v1,r1,X_new);
        X_new = fk_all(v1,r1,X_temp);
        data_dim = data_dim -1; 
        %now apply the next iteration
    end
    %Now find geodesic Mean.
    
    v = geodesic_mean(X_new);
    CurrMap.v = v;
    CurrMap.r = 0;
    Mapping = [Mapping CurrMap];
    
    
    
    %Now you are done finding all the parameters:
    
    %Reconstruct the vector back
    
    

end

function [v] = getFinalVec(V,R,v1)

    depth = size(V,1)
    assert(size(R,1)==size(V,1), 'r and v dont match');
    v=v1;
    if depth ==0
        v1 =v;
        return;
    end
    for i=depth:1
        v = f_inv(V(i,:),R(i),v)
    end
end

