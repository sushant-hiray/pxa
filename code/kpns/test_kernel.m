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
%meanD = mean(Data,2);
%Data = Data - meanD(:,ones(1,size(Data,2)));
%Data = normc(Data)
options.KernelType='NPolyPlus'
for i=1:2:20
    i 
    options.degree=i;
    [ eigvec, eig_val ] = kpca_main(Data,options);
    R_linear = 100*eig_val/sum(eig_val);
    R_linear(1:10)
end