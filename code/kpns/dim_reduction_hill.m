%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/HillValley.mat');
HillValleywithnoiseTraining = HillValleywithnoiseTraining';

Total_R = dim_reduction_data2(HillValleywithnoiseTraining,'Hill Valley',1,1);
Total_R
%dim_reduction_sampling(HillValleywithnoiseTraining,'Hill Valley',5);