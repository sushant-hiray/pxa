%% This test generates data using the VonMissFischer Distribution and tries
%  to compute modes of variations and geodesic mean. 
dim = 4;
mu = zeros(dim,1);
mu(end) =1;
Data = randvonMisesFisherm(dim,1000, 100, mu)

[Mapping,gm_pns,Var] = pnsMain(Data,1);
gm_intrinsic = geodesic_mean(Data);
