function [Mapping, X_pns,X_BackErr] = pns( X )
%X is the data points. datadim x no.of data points

    data_dim = size(X,1);
    Mapping = [];
    X_pns = [];
    InitialData = X;
    X_new = X;
    r_prod = 1;
    X_BackErr =[];
    while data_dim > 2
        %finding the vector with least error(Best Rep)
        %global Data is set in applyLM
        %{
        if(data_dim == 4)
             [v1 r1]=  applyLM(X_new, [ -0.2396   -0.8620   -0.0272   -0.4459]');
        elseif(data_dim == 5)
            [v1 r1]=  applyLM(X_new, [ 0.4847    0.0601    0.0212    0.5398   -0.6853]');
        elseif(data_dim == 3)
             [v1 r1]=  applyLM(X_new, [0.1486   -0.1190   -0.9817]');
        elseif(data_dim == 2)
             [v1 r1]=  applyLM(X_new, [ 0.2522    0.9677 ]');
        else
             [v1 r1]=  applyLM(X_new, rand(data_dim,1));
        end
        %}
        [v1, r1]=  applyLM2(X_new, rand(data_dim,1));
        r_prod = r_prod*sin(r1);
        
        CurrMap.v = v1;
        CurrMap.r = r1;
        CurrMap.r_prod = r_prod;
        
        Mapping = [Mapping CurrMap];
        'Converged at dim';
        data_dim;
        'with error';
        %compute_error(v1)
        %CurrError = residual_error(X_new, v1, r1, r_prod);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Compute Error at this layer, project the data to the final layer
        
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %X_pns = [CurrError; X_pns];
        
        %pause
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % This code is fine
        %project data on to the surface
        X_temp = project_all(v1,r1,X_new);  
        % check if v1. all X_temp is zero
        v1_temp = repmat(v1, 1, size(X_temp,2));
        assert(sum(sum(X_temp.*v1_temp,1).^2) < 1E-2, 'projection and normal not perpendicular');
        %prependicular is verified
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        % rotate data to north pole
        X_new = fk_all(v1,r1,X_temp);
        
        backErr = X - backProject(X_new, Mapping);
        backErr
      
         
        
        backErr = backErr.^2;
        backErr = sum(backErr(:))/size(X,2);
        'backErr is'
        backErr
        'for dimension'
        data_dim
        X_BackErr = [X_BackErr backErr];       
        data_dim = data_dim -1; 
        %now apply the next iteration
    end
    %Now find geodesic Mean.
    
    v = geodesic_mean(X_new);
    CurrMap.v = v;
    CurrMap.r = 0;
    CurrMap.r_prod = r_prod;
    CurrError = residual_error(X_new, v, 0, r_prod);
    Mapping = [Mapping CurrMap];
    X_pns = [CurrError; X_pns];

    %Now you are done finding all the parameters:
    
    %Reconstruct the vector back
end