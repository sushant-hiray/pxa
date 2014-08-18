function [meanShape,V,D] = pga(Samples)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    data_size = size(Samples);
    no_of_samples = data_size(1);
    meanShape = geodesic_mean(Samples,no_of_samples,0.3,0.001);
    %plot(meanShape(1:56),meanShape(57:end),'b+');
    size(meanShape);
    [V,D] = pca(meanShape,Samples,no_of_samples);
end

