%% This test generates data using the VonMissFischer Distribution and tries
%  to compute modes of variations and geodesic mean. 
rng(0)
Data = randvonMisesFisherm(3,200, 100, [0 0 1])

[Mapping,BkGm,R,Res] = kernel_pnsMain(Data,1,1);
gm_intrinsic = geodesic_mean(Data);
gm_pns = Mapping(end).v;
gm_pns = Data*gm_pns;
plot3(Data(1,:),Data(2,:),Data(3,:),'b.');
hold on;
plot3(gm_pns(1,:),gm_pns(2,:),gm_pns(3,:),'r*');
hold on;
plot3(gm_intrinsic(1,:),gm_intrinsic(2,:),gm_intrinsic(3,:),'g*');

%%