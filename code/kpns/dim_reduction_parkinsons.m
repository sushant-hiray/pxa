%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/pk.mat');
Data=pk';
PGS =1;

% Total_R = dim_reduction_data(Data,'Parkinsons');
% Total_R

new_boxplot(Data,'Parkinsons',5);