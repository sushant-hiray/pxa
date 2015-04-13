function [center, r] = Kernel_findSphere(G,KData,prevMapping,singular_value) 
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
    one_mat = ones(size(K))./N;
    K_center = NewK - one_mat*NewK - NewK*one_mat + one_mat*NewK*one_mat;
    [eigvec,eigval] = svd(K_center);
    
    [~, index] = sort(eigval,'descend');
   
    V = eigvec(:,index(singular_value));
    TempMat1 = (ones(size(NewK)) -eye(size(NewK)))/N + eye(size(NewK));
    Vfinal = KData*TempMat1*V;
    
    
    %V(:) =0; V(end)=1;
	% Now start applying gradient descent with the objective function to
	% optimize for v and r depending upon the parameter type
	% Initialization happens using V as the intial value of V0
    
    r=pi/2;
    center = kernel_optimization_find_v(G,KData,Vfinal,prevMapping);
   
end