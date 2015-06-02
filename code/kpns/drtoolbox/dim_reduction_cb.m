%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/cb.mat');
cb = cb';

[mapped_data, mapping] = compute_mapping(cb', 'MDS', 40);
mapped_data=mapped_data';
