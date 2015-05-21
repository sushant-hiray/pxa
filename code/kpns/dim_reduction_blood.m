%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/transfusion.mat');
transfusion = transfusion(:,2:end-1);
transfusion = transfusion';
Total_R = dim_reduction_data(transfusion,'Blood Transfusion');