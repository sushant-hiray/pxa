function [QDR] = collectDataNewMethods(matPath,dim)
    matPath
    
    load(matPath);
    
    N = size(Data,2);
    QDR= zeros(3,N);
    
    [mapped_data,~] = compute_mapping(Data', 'MDS', dim);
    QDR(1,:) = getQDRForNewMethods(Data,mapped_data');
    

    [mapped_data,~] = compute_mapping(Data', 'NPE', dim);
    QDR(2,:) = getQDRForNewMethods(Data,mapped_data');
    
    [mapped_data,~] = compute_mapping(Data', 'LDA', dim);
    QDR(3,:) = getQDRForNewMethods(Data,mapped_data');
    QDR = QDR';
end
