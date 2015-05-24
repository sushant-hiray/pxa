function [A] =  dim_reduction_sampling(Data,filename,noSamples)
    NoGraphs = 7;
    TotalPoints = size(Data,2);
    
    for i=1:noSamples
        tempFileName = strcat(filename , int2str(i));
        DataSampled = datasample(Data,ceil(0.8*TotalPoints),2);
        dim_reduction_data(DataSampled,tempFileName);
    end
    
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
    figure()
    axis([0 ceil(0.08*TotalPoints) 0 1])
    new_A = A(:,1:10:end,:);
    Col = hsv(7);
    for i =1 : NoGraphs
        boxplot(new_A(:,:,i),'colors',Col(i,:));
        hold on;
    end
    hlegend = legend(findall(gca,'Tag','Box'), {'KPNS-Gauss','KPCA-Gauss','KPNS-NPoly3','KPCA-NPoly3','KPNS-NPoly5','KPCA-NPoly5','PCA'});
    hChildren = findall(get(hLegend,'Children'), 'Type','Line');
    set(hChildren(6),'Color',Col(1,:));
    set(hChildren(4),'Color',Col(2,:));
    set(hChildren(2),'Color',Col(3,:));

end