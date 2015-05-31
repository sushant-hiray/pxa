function   boxplot_QDR(A,name)
    scrsz = get(0,'ScreenSize');
    figure('Position',scrsz); hold on;
    new_A = A;
    Col = hsv(7);
    size_new_A = size(new_A);
    index = 1:size_new_A(2);
    
    % Medians
    plot( index-0.2, median(new_A(:,:,1), 1), '-', index-0.2, median(new_A(:,:,1), 1), '*','Color',Col(1,:),'LineWidth',2);
    plot( index-0.1, median(new_A(:,:,2), 1), '-', index-0.1, median(new_A(:,:,2), 1), '*','Color',Col(2,:),'LineWidth',2);
    plot( index+0.1, median(new_A(:,:,3), 1), '-', index+0.1, median(new_A(:,:,3), 1), '*','Color',Col(3,:),'LineWidth',2);
    plot( index+0.2, median(new_A(:,:,4), 1), '-', index+0.2, median(new_A(:,:,4), 1), '*','Color',Col(4,:),'LineWidth',2);
    plot( index    , median(new_A(:,:,5), 1), '-', index    , median(new_A(:,:,5), 1), '*','Color',Col(5,:),'LineWidth',2);


    
    %Box Plots
    i=1; 
    bp = boxplot(new_A(:,:,i),'positions', index - 0.2, 'symbol', '', 'notch', 'off', 'whisker', 1.5 , 'widths', 0.3);
    set (bp (:,1:end), 'color', Col(i,:), 'linewidth', 1);
    hold on;
    delete (findobj (gca, 'Type', 'text'));
    
    i=2;
    bp = boxplot(new_A(:,:,i),'positions', index - 0.1, 'symbol', '', 'notch', 'off', 'whisker', 1.5 ,'widths', 0.3);
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    i=3; 
    bp = boxplot(new_A(:,:,i),'positions', index + 0.1, 'symbol', '', 'notch', 'off', 'whisker', 1.5 ,'widths', 0.3);
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    
    i=4;
    bp = boxplot(new_A(:,:,i),'positions', index + 0.2, 'symbol', '', 'notch', 'off', 'whisker', 1.5,'widths', 0.3);
    set (bp (:,1:end), 'color', Col(i,:) , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    i=5;
    indexshow = num2str (index');
    indexshow (2:4:end,:) = ' '; indexshow (3:4:end,:) = ' '; indexshow (4:4:end,:) = ' ';
    bp = boxplot(new_A(:,:,i),'positions', index,'color', Col(i,:), 'symbol', '', 'notch', 'off', 'whisker', 1.5 , 'Labels', indexshow,'widths', 0.3);
    
    
    %Legend
    hLegend = legend(findall(gca,'Tag','Box'), {'KPNS-Gauss','KPCA-Gauss','KPNS-NPoly5','KPCA-NPoly5','PCA'},'Location', 'southeast');
    set(hLegend,'FontSize',30);
    hChildren = findall(get(hLegend,'Children'), 'Type','Line');
    set(hChildren(2),'Color',Col(5,:), 'linewidth', 2);
    set(hChildren(4),'Color',Col(4,:), 'linewidth', 2);
    set(hChildren(6),'Color',Col(3,:), 'linewidth', 2);
    set(hChildren(8),'Color',Col(2,:), 'linewidth', 2);
    set(hChildren(10),'Color',Col(1,:), 'linewidth', 2);
    set(gcf, 'Color', 'w');
    
%   This is for y-axis labels
    set(gca,'fontsize',30);

%   This is for x-axis labels
    txt = findobj(gca,'Type','text');
    set(txt(3:end),'VerticalAlignment', 'Middle');
    set(findobj(gca,'Type','text'),'FontSize',30);

    xlabel ('k-Neighbourhood', 'FontSize', 50);
    ylabel ('Quality DR', 'FontSize', 50);
    title(name,'FontSize',50);
    axis tight; a = axis; a(3) = a(3) - 0.05; axis (a); grid on;axis tight;
    filePath = strcat('../images/',name,'/boxplot_Frac_', name,'_',int2str(size(A,1)));
    export_fig(filePath,'-nocrop', '-painters','-a2', '-png');

end