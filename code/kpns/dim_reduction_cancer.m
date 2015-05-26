%% Comments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)


load('../../data/cancer.mat');
cancer = cancer';

Total_R = dim_reduction_data(cancer,'Lung Cancer',1);
Total_R