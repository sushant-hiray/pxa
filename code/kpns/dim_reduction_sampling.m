function  dim_reduction_sampling(Data,name,noSamples,maxDims,loadData)
    %addPath('drtoolbox/');
    %addPath('drtoolbox/techniques');
    close all;
    TotalPoints = size(Data,2);
    %Typically noSamples is like 25
    
    noOfGraphs =8;
    fprintf('Working on %s Dataset\n ', name);
    if(loadData==0)
        for i=1:noSamples
            if(i==1)
                continue;
            end
            DataSampled = datasample(Data,ceil(0.8*TotalPoints),2);
            dim_reduction_data4(DataSampled,name,maxDims,0,i);
        end
    end
    minDim = 20;
    A = zeros(noSamples,ceil(0.8*TotalPoints),noOfGraphs);
    B = zeros(noSamples,minDim,noOfGraphs);
    filePath = strcat('../images/',name);
    
    for i=1:noSamples
       matPath = strcat(strcat(filePath,'/'), strcat(name,int2str(i)));
       matPath = strcat(matPath,'.mat');
       
       %Load Data
           [A(i,:,1:5),maxDim] = getQDR(matPath);
       B(i,:,1:5)   = getFracR(matPath,minDim);
       
       A(i,:,6:end) = collectDataNewMethods(matPath,maxDim);
       
       
    end
    
    boxplot_QDR(A,name);
    boxplot_Frac(B,name);
end