rng(0);
PGS =1
Data =  generate_ellipse(100,8)
[Mapping,BkGm,R,Res] = kernel_pnsMain(Data,1,PGS);
BkGm = Data*BkGm;
figure();
subplot(1,2,1);
plot_data(Data,0);
axis equal tight;
subplot(1,2,2);
plot_data(BkGm,0);
axis equal tight;