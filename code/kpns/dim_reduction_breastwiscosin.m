%% Comments : KPNS > KPCA Guassian kernel 3-4%


clc
clear all
close all
rng(0)

load('../../data/breastwiscosin.mat');
breastwiscosin = breastwiscosin';
Total_R = dim_reduction_data2(breastwiscosin,'Breast Cancer Wiscosin (Original)',1,0);
%dim_reduction_sampling(breastwiscosin,'Breast Cancer Wiscosin (Original)',5);