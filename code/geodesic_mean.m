function [ mean ] = geodesic_mean(Samples,N,step_size)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% Samples are normalized
% N is number of Samples
if (N ==0)
    mean = 0
    disp('No of Samples cannot be zero')
    return
    
    
mean = Samples(1,:);
prevmean = Samples(1,:);
meanError;
data_dim = 

while(true)
    
sums=zeros(
for i in 1:N
    sums = sums+log_map(mean,S(i));
    
gradF = (-1/N)*sums;

mean = exp_map(mean,(step_size*(-gradF));
meanError = log_map(prevmean,mean);

if meanError < 

    
end

