%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/SPECT2.mat');
SPECT = SPECT(:,1:end-1);
rng(0);
%SPECT = normc(SPECT');
PGS =1;
SPECT = SPECT';

Total_R = dim_reduction_data(SPECT,'SPECT2');
Total_R