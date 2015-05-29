%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/transfusion.mat');
transfusion = transfusion(:,2:end-1);
transfusion = transfusion';
Total_R = dim_reduction_data2(transfusion,'Blood Transfusion',1,1);
%plot_QDR(transfusion,'Blood Transfusion');
