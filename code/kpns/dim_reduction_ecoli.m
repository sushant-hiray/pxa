%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all

load('../../data/ecoli.mat');
ecoli = ecoli(:,2:end-1);
rng(0);
PGS =1;
ecoli = ecoli';

Total_R = dim_reduction_data2(ecoli,'Ecoli',2,1);
% Total_R
%dim_reduction_sampling(ecoli,'Ecoli',5);
