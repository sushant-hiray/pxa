%% COmments : KPNS > KPCA Guassian kernel 3-4%

clear
load('../../data/haberman.mat');
%sonar = sonar(:);
rng(0);
addpath('../../altmany-export_fig-bdf6154/')
%sonar = normc(sonar');
PGS =1;
haberman = haberman';
Total_R = dim_reduction_data(haberman,'haberman');
Total_R