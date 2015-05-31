%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/wine.mat');

rng(0);
wine = wine';
%wine = normc(wine');
PGS =1;
Total_R = dim_reduction_data2(wine,'Wine',0,1);
% Total_R
%dim_reduction_sampling(wine,'Wine',5);