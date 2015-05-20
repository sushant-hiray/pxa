%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/sonar.mat');
sonar = sonar(:,1:end-1);
rng(0);
%sonar = normc(sonar');
PGS =1;

Total_R = dim_reduction_data(haberman,'haberman');
Total_R