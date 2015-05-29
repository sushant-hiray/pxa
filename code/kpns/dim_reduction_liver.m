%% COmments : KPNS > KPCA Guassian kernel 3-4%


clc
clear all
close all
rng(0)


load('../../data/liver.mat');
%transfusion = normc(transfusion');
PGS =1;
liver = liver';
Total_R = dim_reduction_data2(liver,'ILPD (Indian Liver Patient Dataset)',1,1);
% Total_R
%dim_reduction_sampling(liver,'ILPD (Indian Liver Patient Dataset)',5);