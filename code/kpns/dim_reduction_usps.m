%% COmments : KPNS > KPCA Guassian kernel 3-4%

clc
clear all
close all
rng(0)

load('../../data/usps_all.mat');
Data=[];

i=3;
Data = data(:,1:200,i);

%{
while i <= 1
    Data = [Data data(:,:,i)];
    i=i+1
end
%}
Data = double(Data);
% preprocessing
%Data = Data - repmat(mean(Data), size(Data,1), 1);
%Data = normc(Data);


PGS =1;
% 
%Total_R = dim_reduction_data2(Data,'USPS Dataset',0,1);
%Total_R

dim_reduction_sampling(Data,'USPS Dataset',25,2,0);
