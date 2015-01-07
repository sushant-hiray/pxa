rng(0);
Data =  generate_ellipse(100,8)
[Mapping,BkGm,Var] = pnsMain(Data,1);
figure();
subplot(1,2,1);
plot_data(Data,0);
axis equal tight;
subplot(1,2,2);
plot_data(BkGm,0);
axis equal tight;