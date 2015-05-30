%% This test generates data using the VonMissFischer Distribution and tries
%  to compute modes of variations and geodesic mean. 
rng(0)
Data = randvonMisesFisherm(4,100,2, [0 0 0 1])
%A = zeros(50,size(Data,2)); 
%Data = [Data;A];
Total_R = dim_reduction_data3(Data,'Sim Data2',1,0);

%%