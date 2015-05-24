%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/mnist_all.mat');

Data = test1(1:300,:);
Data = double(Data);
Data = Data';

% preprocessing
Data = Data - repmat(mean(Data), size(Data,1), 1);
Data = normc(Data);


PGS =1;
% 
% Total_R = dim_reduction_data(Data,'MNIST Class 1 Dataset');
% Total_R
dim_reduction_sampling(Data,'MNIST Class 1 Dataset',5);