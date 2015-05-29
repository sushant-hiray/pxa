function [new_A] =  new_boxplot(Data,filename,noSamples)
    TotalPoints = size(Data,2);
    NoGraphs = 7;
    A  = zeros(noSamples,ceil(0.8*TotalPoints),NoGraphs);
    for i=1:noSamples
        name_temp = strcat(filename,int2str(i));
        name_temp = strcat('../images/',name_temp);
        A(i,:,1) = dlmread(strcat(name_temp, 'QDR_KPNS_QUASS.txt'));
        A(i,:,2) = dlmread(strcat(name_temp, 'QDR_KPCA_Gauss.txt'));
        A(i,:,3) = dlmread(strcat(name_temp, 'QDR_KPNS_NPoly_3.txt'));
        A(i,:,4) = dlmread(strcat(name_temp, 'QDR_KPCA_NPoly_3.txt'));
        A(i,:,5) = dlmread(strcat(name_temp, 'QDR_KPNS_NPoly_5.txt'));
        A(i,:,6) = dlmread(strcat(name_temp, 'QDR_KPCA_NPoly_5.txt'));
        A(i,:,7) = dlmread(strcat(name_temp, 'QDR_KPCA_linear.txt'));
    end
    'Done'
    scrsz = get(0,'ScreenSize');
    figure('Position',scrsz); hold on;
    axis([0 ceil(0.08*TotalPoints) 0 1])
    new_A = A(:,1:10:end,:);
    Col = hsv(7);
    size_new_A = size(new_A);
    index = 1:size_new_A(2);
    
    
%     plot ( index-0.3, median (new_A(i,:,1), 1), 'r.-' ,...
%         index-0.2, median (new_A(i,:,2), 1), 'b.-' ,...
%         index-0.1, median (new_A(i,:,3), 1), 'y.-' ,...
%         index+0.1, median (new_A(i,:,4) , 1), 'g.-' ,...
%         index+0.2, median (new_A(i,:,5) , 1), 'm.-' ,...
%         index+0.3, median (new_A(i,:,6) , 1), 'c.-' ,...
%         index, median (new_A(i,:,7), 1), 'k.-', ...
%          'LineWidth', 1);
    legend ('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA', 'Location', 'East');
    i=1; 
    bp = boxplot(new_A(:,:,i),'positions', index - 0.3, 'symbol', '', 'notch', 'off', 'whisker', 1.5 , 'widths', 0.2);
    set (bp (:,1:end), 'color', Col(i,:), 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    
    i=2;
    bp = boxplot(new_A(:,:,i),'positions', index - 0.2, 'symbol', '', 'notch', 'off', 'whisker', 1.5 ,'widths', 0.2);
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    i=3; 
    bp = boxplot(new_A(:,:,i),'positions', index - 0.1, 'symbol', '', 'notch', 'off', 'whisker', 1.5,'widths', 0.2 );
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
%     
    i=4;
    bp = boxplot(new_A(:,:,i),'positions', index + 0.1, 'symbol', '', 'notch', 'off', 'whisker', 1.5,'widths', 0.2 );
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
%     
    i=5; 
    bp = boxplot(new_A(:,:,i),'positions', index + 0.2, 'symbol', '', 'notch', 'off', 'whisker', 1.5 ,'widths', 0.2);
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    
    i=6;
    bp = boxplot(new_A(:,:,i),'positions', index + 0.3, 'symbol', '', 'notch', 'off', 'whisker', 1.5,'widths', 0.2 );
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    
    indexshow = num2str (index');
    indexshow (2:4:end,:) = ' '; indexshow (3:4:end,:) = ' '; indexshow (4:4:end,:) = ' ';
    i=7;
    bp = boxplot(new_A(:,:,i),'positions', index,'color', Col(i,:), 'symbol', '', 'notch', 'off', 'whisker', 1.5 , 'Labels', indexshow,'widths', 0.2);
    
    
  
    
    hLegend = legend(findall(gca,'Tag','Box'), {'KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA'},'Location', 'southeast');
    hChildren = findall(get(hLegend,'Children'), 'Type','Line');
    set(hChildren(2),'Color',Col(7,:));
    set(hChildren(4),'Color',Col(6,:));
    set(hChildren(6),'Color',Col(5,:));
    set(hChildren(8),'Color',Col(4,:));
    set(hChildren(10),'Color',Col(3,:));
    set(hChildren(12),'Color',Col(2,:));
    set(hChildren(14),'Color',Col(1,:));
    set(gcf, 'Color', 'w');
    grid on
    xlabel ('k-Neighbourhood', 'FontSize', 14);
    ylabel ('Quality of Dimensionality Reduction', 'FontSize', 14);
    title(filename,'FontSize',14);
    set (findobj (gca, 'Type', 'text'), 'FontSize', 10);
    axis tight; grid on; a = axis; a(3) = a(3) - 0.05; axis (a);
    filePath = strcat('../images/boxplot_', filename);
    export_fig(filePath,'-nocrop', '-painters','-a2', '-png');
  
