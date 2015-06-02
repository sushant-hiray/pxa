%% Comments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/planningrelax.mat');
planningrelax = planningrelax';
rng(0);
PGS =1;
% Total_R = dim_reduction_data2(planningrelax,'Planning Relax',1,1);
% Total_R
dim_reduction_sampling(planningrelax,'Planning Relax',25,2,0);
