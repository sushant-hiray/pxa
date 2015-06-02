function   boxplot_Frac(A,name)
    scrsz = get(0,'ScreenSize');
    figure('Position',scrsz); hold on;
    new_A = A;
    size_new_A = size(new_A);
    index = 1:size_new_A(2);
    
    % Medians
    plot( index-0.2, median(new_A(:,:,1), 1), 'r.-', ...
    index-0.1, median(new_A(:,:,2), 1), 'b.-', ...
    index+0.1, median(new_A(:,:,3), 1), 'm.-', ...
    index    , median(new_A(:,:,4), 1), 'c.-','LineWidth',2, 'MarkerSize', 25 );
 %  hLegend = legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly5','KPCA-NPoly5','PCA','Location', 'southeast');
    hLegend = legend('KPNS-Gauss','KPCA-Gauss','KPNS-NPoly5','KPCA-NPoly5','Location', 'east');
    set(hLegend,'FontSize',40);
    

    
    %Box Plots
    i=1; 
    bp = boxplot(new_A(:,:,i),'positions', index - 0.2, 'symbol', '', 'notch', 'off', 'whisker', 1.5 , 'widths', 0.2);
    set (bp (:,1:end), 'color', 'r', 'linewidth', 1);
    hold on;
    delete (findobj (gca, 'Type', 'text'));
    
    i=2;
    bp = boxplot(new_A(:,:,i),'positions', index - 0.1, 'symbol', '', 'notch', 'off', 'whisker', 100 ,'widths', 0.2);
    set (bp (:,1:end), 'color', 'b' , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    i=3; 
    bp = boxplot(new_A(:,:,i),'positions', index + 0.1, 'symbol', '', 'notch', 'off', 'whisker', 100 ,'widths', 0.2);
    set (bp (:,1:end), 'color', 'm' , 'linewidth', 1);
    delete (findobj (gca, 'Type', 'text'));
    
    i=4;
    indexshow = num2str (index');
    indexshow (2:2:end,:) = ' ';
    bp = boxplot(new_A(:,:,i),'positions', index,'color', 'c', 'symbol', '', 'notch', 'off', 'whisker', 100 , 'Labels', indexshow,'widths', 0.2);

    set(gcf, 'Color', 'w');
    
%   This is for y-axis labels
    set(gca,'fontsize',30);

%   This is for x-axis labels
    txt = findobj(gca,'Type','text');
    set(txt(1:end),'VerticalAlignment', 'Middle');
    set(findobj(gca,'Type','text'),'FontSize',30);

    xlabel ('Modes of Variation', 'FontSize', 50,'VerticalAlignment', 'Top');
    ylabel ('Quality DR', 'FontSize', 50);
    axis tight; a = axis; a(3) = a(3) - 0.05; axis (a); grid on;axis tight;
    filePath = strcat('../images/',name,'/boxplot_Frac', name,'_',int2str(size(A,1)));
    export_fig(filePath,'-nocrop', '-painters','-a2', '-png');
end