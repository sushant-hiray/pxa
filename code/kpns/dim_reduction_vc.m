%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/vc.mat');
rng(0);
PGS =1;
vc = vc';
Total_R = dim_reduction_data2(vc,'Vertebral Column',0,1);
Total_R
%boxplot_QDR(vc,'Vertebral Column',5);