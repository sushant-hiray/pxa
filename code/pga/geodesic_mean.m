function [ mean ] = geodesic_mean(S,N,step_size,threshold)
    % Samples are normalized
    % N is number of Samples
    assert(N ~= 0,  '[geodesic_mean]: No of Samples cannot be zero');
    assert(threshold < 1,  '[geodesic_mean]: Threshold should be less than 1');

    delta = 0.001;
    mean = S(1,:) - delta;
    mean  = mean/norm(mean) ;% lies on a sphere of radius 1
    prevmean = S(1,:);
    meanChange = 1; % difference in mean
    data_dim = size(mean);
    iter = 0;
    
    while(norm(meanChange) > threshold)
        'jfkdjkslfjldjflkdjl'
        %norm(mean)
        sums = zeros(1,data_dim(1));
        iter = iter+1;
        
        for i = 1:N
            %norm(S(i,:))
            %'fdkjfkjk'
            %pause
            sums = sums+log_map(mean,S(i,:));
        end
        gradF = (-1/N)*sums;
        mean = exp_map(mean,(step_size*(-gradF)));
        meanChange = log_map(prevmean,mean)/(2*pi);
        prevmean = mean;
        
    end
    
    disp('iterations')
    disp(iter);