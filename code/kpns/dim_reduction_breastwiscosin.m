%% Comments : KPNS > KPCA Guassian kernel 3-4%


clc
clear all
close all
rng(0)

load('../../data/breastwiscosin.mat');
breastwiscosin = breastwiscosin';
Total_R = dim_reduction_data(breastwiscosin,'Breast Cancer Wiscosin (Original)');
dim_reduction_sampling(breastwiscosin,'Breast Cancer Wiscosin (Original)',5);