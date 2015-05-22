function [] = plot_QDR( Data, name )

name_temp = strcat('../images/',name);
QDR_KPNS_Gauss = dlmread(strcat(name_temp, 'QDR_KPNS_QUASS.txt'));
QDR_KPCA_Gauss = dlmread(strcat(name_temp, 'QDR_KPCA_Gauss.txt'));
QDR_KPNS_NPoly_3 = dlmread(strcat(name_temp, 'QDR_KPNS_NPoly_3.txt'));
QDR_KPCA_NPoly_3 = dlmread(strcat(name_temp, 'QDR_KPCA_NPoly_3.txt'));
QDR_KPNS_NPoly_5 = dlmread(strcat(name_temp, 'QDR_KPNS_NPoly_5.txt'));
QDR_KPCA_NPoly_5 = dlmread(strcat(name_temp, 'QDR_KPCA_NPoly_5.txt'));
QDR_KPCA_linear = dlmread(strcat(name_temp, 'QDR_KPCA_linear.txt'));


linewidth = 4;
plot(QDR_KPNS_Gauss(2,:),QDR_KPNS_Gauss(1,:),'r-','LineWidth',linewidth);
hold on;
plot(QDR_KPCA_Gauss(2,:),QDR_KPCA_Gauss(1,:),'b-','LineWidth',linewidth);
hold on;
plot(QDR_KPNS_NPoly_3(2,:),QDR_KPNS_NPoly_3(1,:),'y-','LineWidth',linewidth);
hold on;
plot(QDR_KPCA_NPoly_3(2,:),QDR_KPCA_NPoly_3(1,:),'g-','LineWidth',linewidth);
hold on;
plot(QDR_KPNS_NPoly_5(2,:),QDR_KPNS_NPoly_5(1,:),'m-','LineWidth',linewidth);
hold on
plot(QDR_KPCA_NPoly_5(2,:),QDR_KPCA_NPoly_5(1,:),'c-','LineWidth',linewidth);
hold on
plot(QDR_KPCA_linear(2,:),QDR_KPCA_linear(1,:),'k-','LineWidth',linewidth);
%%%%%%%%%%%%%%%
filePath = strcat('../images_new/' , name);
title(name,'FontSize',14);
xlabel('k-Neighbourhood','FontSize',14);
ylabel('Quality of DR','FontSize',14);
legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA','Location', 'southeast')
axis([1,size(Data,2),0,1.1]) 
set(gcf, 'Color', 'w');
% set(findall(gcf,'type','text'),'fontSize',14);
export_fig(filePath,'-nocrop', '-painters','-m2', '-png');

end

