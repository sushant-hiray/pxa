rng(0);
Data = generateTriangleDataSpl(10,1);
[Mapping,BkGm,Var,Res] = pnsMain(Data,1);
figure();
subplot(1,2,1);
plotTrianglesSpl(Data);
axis equal tight;
subplot(1,2,2);
plotTrianglesSpl(BkGm);
axis equal tight;