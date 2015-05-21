%% Comments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/CNAE9.mat');
CNAE9 = CNAE9(:,2:end);
rng(0);
CNAE9 = normc(CNAE9');

Total_R = dim_reduction_data(CNAE9,'CNAE-9');
Total_R