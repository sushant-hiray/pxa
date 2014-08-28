function [meanShape,V,D] = pga(Samples)
    data_size = size(Samples);
    no_of_samples = data_size(1);
    meanShape = geodesic_mean(Samples,no_of_samples,0.3,0.001);
    [V,D] = pca(meanShape,Samples,no_of_samples);
end

