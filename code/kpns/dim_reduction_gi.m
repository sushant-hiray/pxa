%% Comments : KPNS > KPCA Guassian kernel 3-4%


clc
clear all
close all


load('../../data/gi.mat');
gi = gi';
rng(0);
% 
Total_R = dim_reduction_data2(gi,'Glass Identification',1,1);
Total_R

%dim_reduction_sampling(gi,'Glass Identification',5);