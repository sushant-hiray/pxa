function [Mapping] = pns( X )
%X is the data points. datadim x no.of data points

    data_dim = size(X,1);
    Mapping =[];
    X_new = X;
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
        [v1 r1]=  applyLM(X_new, rand(data_dim,1));
        CurrMap.v = v1;
        CurrMap.r = r1;
        Mapping = [Mapping CurrMap];
        'Converged at dim';
        data_dim 
        'with error';
        compute_error(v1)
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

