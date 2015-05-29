%% Comments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/yacht.mat');
yacht = yacht';
rng(0);
PGS =1;
Total_R = dim_reduction_data2(yacht,'Yacht',0,1);
Total_R
%dim_reduction_sampling(yacht,'Yacht',5);