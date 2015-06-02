%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/cb.mat');
cb = cb';

% Total_R = dim_reduction_data2(cb,'Connectionist Bench (Sonar, Mines vs. Rocks)',1,1);
% Total_R
dim_reduction_sampling(cb,'Connectionist Bench (Sonar, Mines vs. Rocks)',25,2,0);