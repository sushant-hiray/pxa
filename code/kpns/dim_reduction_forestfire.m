%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/ff.mat');
Data=ff';
PGS =1;
% Total_R = dim_reduction_data(Data,'lForest Fire');
% Total_R
dim_reduction_sampling(ff,'lForest Fire',5);