%% Comments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all


load('../../data/fertility.mat');
fertility = fertility';
rng(0);

%Total_R = dim_reduction_data2(fertility,'Ferility',1,1);
%Total_R
dim_reduction_sampling(fertility,'Fertility',25,2,0);
