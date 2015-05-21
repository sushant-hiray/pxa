%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/transfusion.mat');
transfusion = transfusion(:,2:end-1);
rng(0);
%transfusion = normc(transfusion');
PGS =1;
transfusion = transfusion';

Total_R = dim_reduction_data(transfusion,'Transfusion');
Total_R