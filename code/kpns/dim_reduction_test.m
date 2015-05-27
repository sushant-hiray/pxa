%% This test generates data using the VonMissFischer Distribution and tries
%  to compute modes of variations and geodesic mean. 
rng(0)
Data = randvonMisesFisherm(4,200, 100, [0 0 0 1])
PGS =1;
% Total_R = dim_reduction_data(Data,'Data');
% Total_R
A =dim_reduction_sampling(Data,'Data',1);

%%