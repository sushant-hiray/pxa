function [V,D] = pca(meanI,Z,n,no_of_samples)
	% array fun
   
    meanI = meanI(:);
    x = size(meanI);
    covar = zeros(x,x);
    K = zeros(x,no_of_samples);
    for i = 1: no_of_samples,
        temp = Z(:,:,i);
        temp = temp(:);
        K(:,i) = temp -meanI;
        size(K(:,i))
        covar = covar + K(:,i)*K(:,i)';
        
        
    end
    covar = covar/no_of_samples;
    [V,D] = eig(covar);
    
    
