function [ mean ] = geodesic_mean(S,N,step_size,threshold)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    % Samples are normalized
    % N is number of Samples
    if (N ==0)
        mean = 0
        disp('No of Samples cannot be zero')
        return
    end
    delta = 0.001;
    mean = S(1,:) -delta;
    mean  = mean/norm(mean)
    prevmean = S(1,:);
    meanChange = 1;
    data_dim = size(mean);
    if(threshold > 1)
        disp('[geodesic_mean]Threshold should be less than 1')
    end
    iter =0;
    while(norm(meanChange) > threshold)
        sums=zeros(1,data_dim(1));
        iter=iter+1;
        for i =1:N
            sums = sums+log_map(mean,S(i,:));
        end
        %sums
        %size(sums)
        gradF = (-1/N)*sums;
        mean = exp_map(mean,(step_size*(-gradF)));
        disp (mean);
        meanChange = log_map(prevmean,mean)/(2*pi);
        prevmean = mean;
        threshold;
    end
    
    disp('iterations')
    disp(iter);