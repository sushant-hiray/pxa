%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)
load('../../data/bt.mat');
Data=bt';
PGS =1;

Total_R = dim_reduction_data(Data,'Breast Tissue',1);
Total_R
%plot_QDR(Data,'Breast Tissue');