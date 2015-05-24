%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)


load('../../data/concreteslump.mat');
concreteslump = concreteslump';
% Total_R = dim_reduction_data(concreteslump,'Concrete Slump');
% Total_R
plot_QDR(concreteslump,'Concrete Slump');