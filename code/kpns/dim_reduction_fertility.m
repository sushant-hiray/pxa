%% Comments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all


load('../../data/fertility.mat');
fertilityDiagnosis = fertilityDiagnosis';
rng(0);

Total_R = dim_reduction_data(fertilityDiagnosis,'Ferility',1);
Total_R