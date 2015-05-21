%% Comments : KPNS > KPCA Guassian kernel 3-4%


clc
clear all
close all


load('../../data/gi.mat');
gi = gi';
rng(0);

Total_R = dim_reduction_data(gi,'Glass Identification');
Total_R