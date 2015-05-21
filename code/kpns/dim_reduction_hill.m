%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/HillValley.mat');
HillValleywithnoiseTraining = HillValleywithnoiseTraining'

Total_R = dim_reduction_data(HillValleywithnoiseTraining,'Hill Valley');
Total_R