%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/vc.mat');
rng(0);
PGS =1;
vc = vc';
% Total_R = dim_reduction_data(vc,'Vertebral Column');
% Total_R
dim_reduction_sampling(vc,'Vertebral Column',5);