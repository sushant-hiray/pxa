%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/cb.mat');
cb = cb';

Total_R = dim_reduction_data(cb,'Connectionist Bench (Sonar, Mines vs. Rocks)');
Total_R