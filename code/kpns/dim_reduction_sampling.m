function [] =  dim_reduction_sampling(Data,filename,noSamples)
    NoGraphs = 7;
    TotalPoints = size(Data,2);
    maxDims = size(Data,1)
    for i=1:noSamples
        tempFileName = strcat(filename , int2str(i));
        DataSampled = datasample(Data,ceil(0.8*TotalPoints),2);
        dim_reduction_data(DataSampled,tempFileName,maxDims);
    end
    boxplot_QDR(Data,filename,noSamples);
end