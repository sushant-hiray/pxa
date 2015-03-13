function [ eigvec, eig_val, data_out ] = kpca_main(data_in, options)
%
% This function does principal component analysis (non-linear) on the given
% data set using the Kernel trick
%
%
% Data_in - Input data (d (dimensions) X N (# of points)
%
%   options       : Struct value in Matlab. The fields in options that can
%                   be set: 
%           KernelType  -  Choices are:
%               'Gaussian'      - e^{-(|x-y|^2)/2t^2}
%               'Polynomial'    - (x'*y)^d
%               'PolyPlus'      - (x'*y+1)^d
%               'Linear'        -  x'*y
%
%               t       -  parameter for Gaussian
%               d       -  parameter for Poly
%

%	Examples:
%           options.KernelType = 'Gaussian';
%           options.t = 1;
%           options.ReducedDim = 4;
% 			fea = rand(7,10);
% 			[eigvector,eigvalue] = KPCA(fea,options);
%           feaTest = rand(3,10);
%           Ktest = construct_kernel(feaTest,fea,options)
%           Y = Ktest*eigvector;
% 

%% Using the Gaussian Kernel to construct the gram matrix K
% K(x,y) = -exp((x-y)^2/(sigma)^2)
sigma = 1;
K = zeros(size(data_in,2),size(data_in,2));
for row = 1:size(data_in,2)
    for col = 1:row
        switch lower(options.KernelType)
            case {lower('Gaussian')}        %  e^{-(|x-y|^2)/2t^2
                temp = sum(((data_in(:,row) - data_in(:,col)).^2));
                K(row,col) = exp(-temp)/(2*sigma*sigma);
            case {lower('PolyPlus')}      % (x'*y + 1)^d
                d = 2;
                K(row,col) = (data_in(:,row)'*data_in(:,col) + 1)^d;
            case {lower('Polynomial')}      % (x'*y)^d
                d = 2;
                K(row,col) = (data_in(:,row)'*data_in(:,col))^d;
            case {lower('Linear')}      % x'*y
                K(row,col) = data_in(:,row)'*data_in(:,col);
            otherwise
                error('KernelType does not exist!');
        end            
    end
end
K = K + K'; 
% Dividing the diagonal element by 2 since it has been added to itself
for row = 1:size(data_in,2)
   K(row,row) = K(row,row)/2;
end

% centering the data:
% Appendix B: Kij = Kij - 1*K - K*1 + 1*K*1
% here 1 refers to 1/M

K_center = K;

one_mat = ones(size(K))./size(data_in,2);
K_center = K - one_mat*K - K*one_mat + one_mat*K*one_mat;
clear K;


%% Obtaining the low dimensional projection
% The following equation needs to be satisfied for K
% M*lamda*alpha = K*alpha (Equation 2.12)
% Thus lamda's has to be normalized by the number of points
opts.issym=1;                          
opts.disp = 0; 
opts.isreal = 1;
neigs = 30;
[eigvec, eig_val] = eig(K_center);
eig_val = eig_val./size(data_in,2); % Normalizing the lambda
eig_val = diag(eig_val);
% 1 = lamda*<alpha,alpha> (Equation 2.14)
for col = 1:size(eigvec,2)
    eigvec(:,col) = eigvec(:,col)./(sqrt(eig_val(col)));
end

[~, index] = sort(eig_val,'descend');
eigvec = eigvec(:,index);
eig_val
%% Projecting the data in lower dimensions
% for now, num_dim = dimension of init data
num_dim = size(data_in,1);
% num_dim = 1;
data_out=eigvec(:,end)
end

