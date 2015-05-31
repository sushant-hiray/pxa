%% This test generates data using the VonMissFischer Distribution and tries
%  to compute modes of variations and geodesic mean. 
rng(0)
dim =23;
mean1 = zeros(1,dim);
mean1(end) =1
Data = randvonMisesFisherm(dim,100,2, mean1)
%A = zeros(50,size(Data,2)); 
%Data = [Data;A];
Total_R = dim_reduction_data2(Data,'Sim Data2',1,0);

%%