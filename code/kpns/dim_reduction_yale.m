clc
clear all
close all
rng(0)
DatabasePath='../../data/CroppedYale/yaleB'; % DatabasePath
ss=10; % sample set size
ns=1   ; % number of subjects

% No ofRows = no of pixels in one images
% No of cols = no of images
Data=[];

for td = 1:ns
    str_temp = DatabasePath;
    if td < 10
        str_temp = strcat(str_temp,'0');
    end
    Files = dir(strcat(str_temp,int2str(td)));
    for i = 1:size(Files,1)
        if not(strcmp(Files(i).name,'.')|strcmp(Files(i).name,'..') | ~isempty(strfind(Files(i).name,'Ambient')) | isempty(strfind(Files(i).name,'.pgm')))
            img = imread(strcat(str_temp,int2str(td),'/',Files(i).name));
            [irow, icol, dim] = size(img);
            if dim>1
                img=rgb2gray(img);
            end
            temp = reshape(img,irow*icol,1);   % Reshaping 2D images into 1D image vectors
            Data = [Data temp];
        end
    end
end

Data = double(Data);
% Each column of data is an image reduced to one dimension

% preprocessing
Data = Data - repmat(mean(Data), size(Data,1), 1);
Data = normc(Data);



PGS =1;
% Total_R = dim_reduction_data(Data,'Yale Image for one class');
% Total_R
plot_QDR(Data,'Yale Image for one class');