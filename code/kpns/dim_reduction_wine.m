%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/wine.mat');
wine = wine(1:59,:);
rng(0);
wine = wine'
%wine = normc(wine');
PGS =1;
Total_R = dim_reduction_data(wine,'wine');
Total_R