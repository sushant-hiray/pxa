function [Mapping, X_pns,X_BackErr,Modes,gm,Var] = pns( X, DEBUG )
%X is the data points. datadim x no.of data points
global debug_flag;
global regnerate_flag;
regnerate_flag= 0;
debug_flag = DEBUG;


if debug_flag == 1 && (size(X,1) ==3)
    plot3(X(1,:),X(2,:),X(3,:), 'y*')
    hold on;
end

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
    % v0 for every iteration is initialized using PCA on the Data and giving the direction which captures the data least.
    X_Corr = X_new*X_new';
    [V,D] = eigs(X_Corr);
    
    v0 = normc(V(:,end)); 
    
    size(v0)
   
    %v0 =rand(data_dim,1);
    
    
    [v1, r1]=  applyLM2(X_new, v0);
%   [v1 r1]  = applyLM(X_new,rand(data_dim,1));
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
        
    if debug_flag == 1 && (size(X_temp,1) ==3)
        plot3(X_temp(1,:),X_temp(2,:),X_temp(3,:), 'g*')
        hold on;
    end
    

    % check if v1. all X_temp is zero
    v1_temp = repmat(v1, 1, size(X_temp,2));
    assert(sum(sum(X_temp.*v1_temp,1).^2) < 1E-2, 'projection and normal not perpendicular');
    %prependicular is verified
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    if regnerate_flag ==1
       gm_k = geodesic_mean(X_temp); 
        
    end
    
    % rotate data to north pole
    X_new = fk_all(v1,r1,X_temp);
    alpha = backProject(X_new, Mapping(end));
    assert(max(max(abs(alpha-X_temp))) < 1E-3, 'backProject not working');
    backErr = X - backProject(X_new, Mapping)   ;
    
    
    if regnerate_flag ==1
       gm_k = geodesic_mean(X_temp); 
       gm_k_1 = geodesic_mean(X_new);
       gm_k_1_bp = backProject(gm_k_1, Mapping(end));
       assert(norm(gm_k_1 -gm_k_1_bp) < 1E-3, 'norms of bp gm and gm dont match');
    end
    
    if debug_flag == 1 && (size(X_new,1) ==2) 
        plot3(X_new(1,:),X_new(2,:),zeros(size(X_new(2,:))), 'c*')
        hold on;
    end
     if debug_flag == 1 && (size(alpha,1) ==3)
        plot3(alpha(1,:),alpha(2,:),alpha(3,:), 'b*')
        %assert(isequal(X_temp, alpha) , 'alpha should be equal to x_temp');
        hold on;
        plot3(X_temp(1,:),X_temp(2,:),X_temp(3,:), 'g*')
        hold on;
    end
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
size(X_new)
X_norm = normc(X_new);
X_norm-X_new;
v = geodesic_mean(X_new);
CurrMap.v = v;
CurrMap.r = 0;
CurrMap.r_prod = r_prod;
CurrError = residual_error(X_new, v, 0, r_prod);

back_proj_gm =  backProject(v, Mapping);
gm = back_proj_gm;
Mapping = [Mapping CurrMap];
X_pns = [CurrError; X_pns];






%Now you are done finding all the parameters:

%Reconstruct the vector back


noOfModes = size(Mapping,2);
variances = zeros(1,noOfModes);
for i=2:noOfModes
    noOfModes
    B = Mapping(i +1:end-1);
    gm_k = backProject(v,Mapping(noOfModes -i+1:end-1));
    variances(i) = compute_variances(InitialData,gm_k,Mapping(1:end-i));
end
Var = variances


% compute the modes of variation:
Modes = find_modes_of_variation(Mapping);

% Now computer variances along each of there directions with respect to
% the geodesic mean.


%{
    gm_rep = back_proj_gm(:,ones(size(InitialData,2),1));
    Error = InitialData -gm_rep;
   
    Var = Modes'*Error;
    Var = Var.^2;
    Var = sum(Var,2);
    Var = normc(Var);
%}

% now project these error on each of the principal modes and compute
% variances




end
