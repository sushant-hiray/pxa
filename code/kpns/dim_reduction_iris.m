%% COmments : KPNS > KPCA Guassian kernel 3-4%

load('../../data/iris.mat');
iris = iris(:,1:4);
rng(0);

PGS =1;
iris = iris';
% plot_QDR(iris,'Iris');
%Total_R = dim_reduction_data(iris,'iris');
%Total_R
dim_reduction_sampling(iris,'iris',5);