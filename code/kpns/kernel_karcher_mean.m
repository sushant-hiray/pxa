function [ mean ] = kernel_karcher_mean(G,KData)
% Computes the karcher Mean of the data points using gradient descent


num_points = size(KData, 2);
assert(num_points ~= 0,  '[kernel_karcher_mean]: No of Samples cannot be zero');
threshold = 1E-5    ;
step_size = 0.1;
assert(threshold < 1,  '[kernel_karcher_mean]: Threshold should be less than 1');

delta = 0.001;
mean = diag(ones(num_points));
mean = mean/num_points;
size(mean)
mean  = mean/kernel_norm(G, mean);
prev_mean = mean;
prev_mean(1) = prev_mean(1) - delta;
prev_mean(2) = prev_mean(2) + delta;
prev_mean = prev_mean/kernel_norm(G,prev_mean);
meanChange = mean-prev_mean; % difference in mean
'mean size is'
size(mean)
'G size is '
size(G)
i=0;
data_dim = size(KData,1);
while(kernel_norm(G, meanChange) > threshold)
    sums = zeros(1,data_dim);
    'computing the projected data'
    projected_data = kernel_log_map(G, KData, mean);
    sums = sum(projected_data, 2);
    gradient = -sums/num_points;
    'computing new mean'
    mean = kernel_exp_map(G, mean, step_size*(-gradient));
    'just after kernal exp map'
    size(mean)
    mean = mean/kernel_norm(G, mean);
    'after computing norm'
    size(mean)
    'computing mean change'
    meanChange = kernel_log_map(G, prev_mean, mean)/2*pi;
    prev_mean = mean;
    i=i+1;
end

