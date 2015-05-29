%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)


load('../../data/concreteslump.mat');
concreteslump = concreteslump';
Total_R = dim_reduction_data2(concreteslump,'Concrete Slump',1,1);
Total_R
%dim_reduction_sampling(concreteslump,'Concrete Slump',5);