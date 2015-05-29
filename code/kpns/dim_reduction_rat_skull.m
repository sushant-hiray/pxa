%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/ratSkull.mat');
Total_R = dim_reduction_data(A,'Rat Skull',1);
%plot_QDR(transfusion,'Blood Transfusion');
