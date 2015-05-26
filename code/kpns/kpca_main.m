function [ eigvec, eig_val, QDR ] = kpca_main(data_in, options)
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
K = zeros(size(data_in,2),size(data_in,2));
G = generateGramMatrix(data_in,options);
K = G;
% centering the data:
% Appendix B: Kij = Kij - 1*K - K*1 + 1*K*1
% here 1 refers to 1/M

K_center = K;
one_mat = ones(size(K))./size(data_in,2);
K_center = K - one_mat*K - K*one_mat + one_mat*K*one_mat;
clear K;
X_mean = mean(data_in,2);
X_shift = data_in -X_mean(:,ones(1,size(data_in,2)));
%% Find the mininum value in kcenter and then add 1/100 of it to the diagonal
K_center = K_center + 0.01*eye(size(K_center));
size(K_center);


%% Obtaining the low dimensional projection
% The following equation needs to be satisfied for K
% M*lamda*alpha = K*alpha (Equation 2.12)
% Thus lamda's has to be normalized by the number of points
opts.issym=1;                          
opts.disp = 0; 
opts.isreal = 1;
neigs = 30;
%[eigvec, eig_val] = eig(K_center);
[eigvec eig_val V] = svd(K_center);

eig_val = eig_val./size(data_in,2); % Normalizing the lambda
eig_val = diag(eig_val);
% 1 = lamda*<alpha,alpha> (Equation 2.14)
for col = 1:size(eigvec,2)
    eigvec(:,col) = eigvec(:,col)./(sqrt(eig_val(col)));
end
eig_val;
[~, index] = sort(eig_val,'descend');
eigvec = eigvec(:,index);
%eigvec = eigvec(:,1:4);
R = (eig_val*100)/sum(eig_val);
QDR= estimateQualityDRKPCA(data_in,eye(size(data_in,2),size(data_in,2)),G,eigvec,R,options.maxDims);
num_points = 1: size(data_in,2);
QDR = [QDR;num_points];
%% Projecting the data in lower dimensions
% for now, num_dim = dimension of init data
num_dim = size(data_in,1);
% num_dim = 1;
end

