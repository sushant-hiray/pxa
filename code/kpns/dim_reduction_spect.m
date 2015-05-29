%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/SPECT.mat');
SPECT = SPECT(:,1:end);
rng(0);
SPECT = normc(SPECT');
PGS =1;
Total_R = dim_reduction_data2(SPECT,'SPECT',0,1);
% Total_R 
% plot_QDR(SPECT,'SPECT');
%dim_reduction_sampling(SPECT,'SPECT',5);
% boxplot_QDR(SPECT,'SPECT',5);