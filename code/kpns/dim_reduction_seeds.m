%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/seeds.mat');
seeds = seeds';
rng(0);
% PGS =1;
% Total_R = dim_reduction_data(seeds,'Seeds');
% Total_R
dim_reduction_sampling(seeds,'Seeds',5);