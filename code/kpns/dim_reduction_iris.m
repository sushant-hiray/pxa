%% COmments : KPNS > KPCA Guassian kernel 3-4%

addpath('../../altmany-export_fig-bdf6154/')
load('../../data/iris.mat');
iris = iris(:,1:4);
rng(0);

PGS =1;
iris = iris';
Total_R = dim_reduction_data(iris,'iris');
Total_R