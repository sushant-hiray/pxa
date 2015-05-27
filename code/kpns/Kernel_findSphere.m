function [center, r,leftDims] = Kernel_findSphere(G,KData,prevMapping,singular_value,Data) 
%type =0 r not fixed to pi/2
%type =1 r = pi/2
    %% 
    %center =  \sum\limits_{i=1}^{l} \alpha_{i} \phi(x_{i})
    % r = pi/2
    
    %Kpca on the data that is mapped into the kernel feature space G = Gram
    %Matrix 
    % Consiedering the eigen vectors
    % e1 = \sum \limits_{i=1}^{l}  \beta_{i} \phi(x_{i})
    
    %%
    %[ eigvec, eig_val, K_center ] = kpca_main(KData, options)
    N = size(KData,2);
    NewK = KData'*G*KData;
    one_mat = ones(size(NewK))./N;
%    K_center = NewK - one_mat*NewK - NewK*one_mat + one_mat*NewK*one_mat;
    K_center = NewK;
    [eigvec,eigval] = svd(K_center);
    eigval = diag(eigval);
    [~, index] = sort(eigval,'descend');
    %Remove the eigenVector that has zero variance (zero eig_val ) Threshold = 1E-10;
    id  = find(eigval > 1E-10);
    id
%    V = eigvec(:,id(size(id,1) -singular_value));
    V = eigvec(:,id(size(id,1)));
   
   
    % Ignore Dimensions which have zero variance in them.
    %TempMat1 = -ones(size(NewK))/N + eye(size(NewK));
    TempMat1 = eye(size(NewK));
    Vfinal = KData*TempMat1*V;
    
    Vfinal = Vfinal/sqrt(Vfinal'*G*Vfinal);
    
    %V(:) =0; V(end)=1;
	% Now start applying gradient descent with the objective function to
	% optimize for v and r depending upon the parameter type
	% Initialization happens using V as the intial value of V0
    
    r=pi/2;
    %TData = kernel_log_map(G,KData,Vfinal);
    center = kernel_optimization_find_v(G,KData,Vfinal,prevMapping,Data);
    leftDims = size(id,1) -1;
end