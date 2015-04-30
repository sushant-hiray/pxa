rng(0);
Data = generateTriangleDataSpl(10,1);
[Mapping,BkGm,R,Res] = kernel_pnsMain(Data,1);
BkGm = Data*BkGm
figure();
subplot(1,2,1);
plotTrianglesSpl(Data);
axis equal tight;
subplot(1,2,2);
plotTrianglesSpl(BkGm);
axis equal tight;