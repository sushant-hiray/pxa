function [ V,D] = pca(meanI,Z,no_of_samples)
% PCA on geodesic distances
% meanI = row vector of mean.
% Z = Samples one row per sample
    x = size(meanI);
% x(2) is the dimension
    covar = zeros(x(2),x(2));
    K = zeros(no_of_samples,x(2));
    for i = 1: no_of_samples,
        temp = log_map(meanI,Z(i,:));
        K(i,:) = temp;
        a = K(i,:)'*K(i,:);
        covar = covar + a;
    end
    covar = covar/no_of_samples;
    [V,D] = eig(covar);
end
