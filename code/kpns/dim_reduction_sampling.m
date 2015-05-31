function  dim_reduction_sampling(Data,name,noSamples,maxDims,loadData)
    close all;
    TotalPoints = size(Data,2);
    %Typically noSamples is like 25
    
    noOfGraphs =5;
    fprintf('Working on %s Dataset\n ', name);
    if(loadData==0)
        for i=1:noSamples
            DataSampled = datasample(Data,ceil(0.8*TotalPoints),2);
            dim_reduction_data4(DataSampled,name,maxDims,0,i);
        end
    end
    minDim = 10;
    A = zeros(noSamples,ceil(0.8*TotalPoints),noOfGraphs);
    B = zeros(noSamples,minDim,noOfGraphs);
    filePath = strcat('../images/',name);
    for i=1:noSamples
       matPath = strcat(strcat(filePath,'/'), strcat(name,int2str(i)));
       matPath = strcat(matPath,'.mat');
       %Load Data
       A(i,:,:) = getQDR(matPath);
       B(i,:,:)   = getFracR(matPath,minDim);
    end
    
    boxplot_QDR(A,name);
    boxplot_Frac(B,name);
end