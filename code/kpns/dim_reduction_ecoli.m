%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all

load('../../data/ecoli.mat');
ecoli = ecoli(:,2:end-1);
rng(0);
PGS =1;
ecoli = ecoli';

Total_R = dim_reduction_data(ecoli,'Ecoli',1);
Total_R