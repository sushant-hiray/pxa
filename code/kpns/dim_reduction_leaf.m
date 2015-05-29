%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/leaf.mat');
Data=leaf';

Data = double(Data);

PGS =1;

Total_R = dim_reduction_data2(Data,'Leaf',1,1);
Total_R
%dim_reduction_sampling(Data,'Leaf',5);