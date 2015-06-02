    %% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/pk.mat');
Data=pk';
PGS =1;

% Total_R = dim_reduction_data2(Data,'Parkinsons',1,1);
% Total_R

dim_reduction_sampling(Data,'Parkinsons',25,2,1);
%new_boxplot(Data,'Parkinsons',5);
