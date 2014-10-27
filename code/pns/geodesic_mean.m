function [ mean ] = geodesic_mean(X)
    % Samples are normalized
    % N is number of Samples
    N = size(X,2);
    assert(N ~= 0,  '[geodesic_mean]: No of Samples cannot be zero');
    threshold = 1E-5;
    step_size = 0.1;
    assert(threshold < 1,  '[geodesic_mean]: Threshold should be less than 1');
    
    delta = 0.001;
    mean = X(:,1) - delta;
    mean  = mean/norm(mean) ;% lies on a sphere of radius 1
    prevmean = X(:,1);
    meanChange = 1; % difference in mean
    data_dim = size(mean,2);
    iter = 0;
    
    while(norm(meanChange) > threshold)
        
        sums = zeros(1,data_dim);
        iter = iter+1;
        
        for i = 1:N
            sums = sums+log_map(mean,X(:,i));
        end
        gradF = (-1/N)*sums;
        mean = exp_map(mean,(step_size*(-gradF)));
        mean = normc(mean);
        meanChange = log_map(prevmean,mean)/(2*pi);
        prevmean = mean;

    end