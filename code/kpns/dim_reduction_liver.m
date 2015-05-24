%% COmments : KPNS > KPCA Guassian kernel 3-4%


clc
clear all
close all
rng(0)


load('../../data/liver.mat');
%transfusion = normc(transfusion');
PGS =1;
liver = liver';
% Total_R = dim_reduction_data(liver,'ILPD (Indian Liver Patient Dataset)');
% Total_R
plot_QDR(liver,'ILPD (Indian Liver Patient Dataset)');