clc
clear all
close all
rng(0)
DatabasePath='../../data/ORL/s'; % DatabasePath
ss=10; % sample set size
ns=40; % number of subjects


% Data format: img x no of samples where img is 2d image reshaped into 1d
% vector

Data=[];

for td = 1:ns
    Files = dir(strcat(DatabasePath,int2str(td)));
    for i = 1:size(Files,1)
        if not(strcmp(Files(i).name,'.')|strcmp(Files(i).name,'..'))
            img = imread(strcat(DatabasePath,int2str(td),'/',Files(i).name));
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
