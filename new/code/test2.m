%% This test generates data using the VonMissFischer Distribution and tries
%  to compute modes of variations and geodesic mean. 
mu = zeros(10,1);
mu(end) =1;
Data = randvonMisesFisherm(10,1000, 100, mu)

[Mapping,gm_pns] = pnsMain(Data,1);
gm_intrinsic = geodesic_mean(Data);
