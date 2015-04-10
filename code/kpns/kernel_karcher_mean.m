function [ mean ] = kernel_karcher_mean( data_in )
% Computes the karcher Mean of the data points using gradient descent

num_points = size(data_in, 2);

assert(num_points ~= 0,  '[kernel_karcher_mean]: No of Samples cannot be zero');
threshold = 1E-5    ;
step_size = 0.1;
assert(threshold < 1,  '[kernel_karcher_mean]: Threshold should be less than 1');

G = generateGramMatrix(data_in,'Linear');
delta = 0.001;
mean = sum(data_in,2)/num_points;
mean  = mean/kernel_norm(G, mean);
prev_mean = mean - delta;

meanChange = 1; % difference in mean

while(kernel_norm(G, meanChange) > threshold)
    sums = zeros(1,data_dim);
    projected_data = kernel_log_map(G, mean, data_in);
    sums = sum(projected_data, 2);
    gradient = -sums/num_points;
    mean = kernel_exp_map(G, mean, step_size*(-gradient));
    mean = kernel_norm(G, mean);
    meanChange = kernel_log_map(G, prev_mean, mean)/2*pi;
    prev_mean = mean;
end

