%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/usps_all.mat');
Data=[];

i=1;
Data = data(:,1:200,i);

%{
while i <= 1
    Data = [Data data(:,:,i)];
    i=i+1
end
%}
Data = double(Data);
% preprocessing
Data = Data - repmat(mean(Data), size(Data,1), 1);
Data = normc(Data);


PGS =1;

Total_R = dim_reduction_data(Data,'USPS Dataset');
Total_R