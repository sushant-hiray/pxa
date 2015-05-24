%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/SPECT.mat');
SPECT = SPECT(:,1:end);
rng(0);
SPECT = normc(SPECT');
PGS =1;

% Total_R = dim_reduction_data(SPECT,'SPECT');
% Total_R

plot_QDR(SPECT,'SPECT');