%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)
load('../../data/bt.mat');
Data=bt';
PGS =1;

% Total_R = dim_reduction_data(Data,'Breast Tissue');
% Total_R
dim_reduction_sampling(Data,'Breast Tissue',5);