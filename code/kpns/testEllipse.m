rng(0);
PGS =1
Data =  generate_ellipse(100,8)
[Mapping, BkGm,Res,NewBPData,AllRes] = pnsMain(Data,1,PGS);
figure();
subplot(1,2,1);
plot_data(Data,0);
axis equal tight;
subplot(1,2,2);
plot_data(BkGm,0);
axis equal tight;