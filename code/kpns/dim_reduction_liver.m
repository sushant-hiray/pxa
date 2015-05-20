%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/liver.mat');
rng(0);
%transfusion = normc(transfusion');
PGS =1;
liver = liver';
Total_R = dim_reduction_data(liver,'liver');
Total_R