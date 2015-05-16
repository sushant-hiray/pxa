function [eigvector, eigvalue] = KPCA(data, options)
%KPCA	Kernel Principal Component Analysis
%
%	Usage:
%       [eigvector, eigvalue] = KPCA(data, options)
% 
%             Input:
%               data    - 
%                      if options.Kernel = 0
%                           Data matrix. Each row vector of fea is a data
%                           point. 
%                      if options.Kernel = 1
%                           Kernel matrix. 
%
%             options   - Struct value in Matlab. The fields in options
%                         that can be set:
%                      Kernel  -  1: data is actually the kernel matrix. 
%                                 0: ordinary data matrix. 
%                                   Default: 0 
%                         
%                       Please see constructKernel.m for other Kernel options. 
%
%                     ReducedDim   - The dimensionality of the reduced subspace. If 0,
%                         all the dimensions will be kept. Default is 30. 
%
%             Output:
%               eigvector - Each column is an embedding function, for a new
%                           data point (row vector) x,  y = K(x,:)*eigvector
%                           will be the embedding result of x.
%                           K(x,:) = [K(x1,x),K(x2,x),...K(xm,x)]
%               eigvalue  - The sorted eigvalue of PCA eigen-problem. 
%
%	Examples:
%           options.KernelType = 'Gaussian';
%           options.t = 1;
%           options.ReducedDim = 4;
% 			fea = rand(7,10);
% 			[eigvector,eigvalue] = KPCA(fea,options);
%           feaTest = rand(3,10);
%           Ktest = constructKernel(feaTest,fea,options)
%           Y = Ktest*eigvector;
% 
%Reference:
%
%   Bernhard Sch�lkopf, Alexander Smola, Klaus-Robert M�ller, �Nonlinear
%   Component Analysis as a Kernel Eigenvalue Problem", Neural Computation,
%   10:1299-1319, 1998.
%
% 
%   version 1.1 --Dec./2011 
%   version 1.0 --April/2005 
%
%   Written by Deng Cai (dengcai AT gmail.com)
%                                                   
MAX_MATRIX_SIZE = 1600; % You can change this number according your machine computational power
EIGVECTOR_RATIO = 0.1; % You can change this number according your machine computational power


ReducedDim = 30;
if isfield(options,'ReducedDim')
    ReducedDim = options.ReducedDim;
end


K = generateGramMatrix(data,options.KernelType);
    
nSmp = size(K,1);
sumK = sum(K,2);
H = repmat(sumK./nSmp,1,nSmp);
K = K - H - H' + sum(sumK)/(nSmp^2);
K = max(K,K');
clear H;

    [eigvector, eigvalue] = eig(K);
    eigvalue = diag(eigvalue);
    
    [dump, index] = sort(-eigvalue);
    eigvalue = eigvalue(index);
    eigvector = eigvector(:,index);
    A =100*eigvalue/sum(eigvalue);
    A(1:10)
end