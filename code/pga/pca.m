function [ V,D] = pca(meanI,Z,no_of_samples)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% PCA on geodesic distances
    % meanI = row vector of mean.
    % Z = Samples one row per sample
    disp('hi')
    
    x = size(meanI);
    covar = zeros(x(2),x(2));
    K = zeros(no_of_samples,x(2));
    for i = 1: no_of_samples,
        size(Z(i,:));
        size(meanI);
        temp = log_map(meanI,Z(i,:));
        size(temp);
        size(temp -meanI);
        %K(i,:) = temp-meanI;
        K(i,:) = temp;
        'dot of k and mean'
        dot(temp,meanI)
        size(K(i,:));
        a = K(i,:)'*K(i,:);
        %covar = covar + K(i,:)'*K(i,:);
        'size XTX'
        size(a)
        covar = covar + a;

    end
    covar = covar/no_of_samples;
    [V,D] = eig(covar);
    disp('checking sizes');
    size(V(:,1))
    size(meanI)
    size(D)
  
    
end

