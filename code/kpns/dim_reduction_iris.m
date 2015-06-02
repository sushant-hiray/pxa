%% COmments : KPNS > KPCA Guassian kernel 3-4%

clear
load('../../data/iris.mat');
iris = iris(:,1:4);
rng(0);

PGS =1;
iris = iris';

% plot_QDR(iris,'Iris');
% Total_R = dim_reduction_data2(iris,'iris',1,1);
% Total_R
dim_reduction_sampling(iris,'Iris',25,2,0);
