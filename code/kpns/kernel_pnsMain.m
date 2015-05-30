function [Mapping,BkGm,R,Res,QDR,G] = kernel_pnsMain(Data, debugMode,mode,options)
	%% Initialize with null, and start finding the modes of variation 
	Mapping = [];

	data_dim = size(Data,1);
	X = Data;
    Res = [];
    RProd = 1;
    newMode =0;
    
    G = generateGramMatrix(Data,options);
    
    num_points = size(Data,2);
    KData = eye(num_points,num_points);
    kernel_dim = 0;
    %KData = normalizeKernelData(G,KData);
    leftDims = size(Data,2);
    Res = [];
	while leftDims > 2
        [v,r,leftDims] = Kernel_findSphere(G,KData,Mapping,kernel_dim,Data);
	
        CurrentMapping.v = v;
   		CurrentMapping.r = r;
        res = kernel_residual_vec(G,KData,v,r);
        Res = [res;Res];
        Mapping = [Mapping CurrentMapping];
		fprintf('Error at Dim  %d is %f\n',leftDims,residual(KData,CurrentMapping.v,CurrentMapping.r));
        %Residual = [Residual residual(X,CurrentMapping.v,CurrentMapping.r)];
        %Update the Data dimensionality and rotate the data.
		KData = kernel_projectData(G,KData,CurrentMapping,Data,Mapping);
	    %assert(abs(norm(K(:,1)) -1) <1E-4, 'norm not 1'); 
        kernel_dim = kernel_dim + 1;
    end
	%% Find the geodesic mean for the Data
    'computing kernel Karcher mean'
	gm = kernel_karcher_mean(G,KData,Mapping);
    
    rankKData = rank(kernel_log_map(G,KData,gm));
    fprintf('Rank of Matrix %f ', rankKData);
    [U S] = svd(kernel_log_map(G,KData,gm));
    S = diag(S);
    fprintf('SVD Rank ');
    S(1:rankKData+1);
	
    CurrentMapping.v = gm;
	CurrentMapping.r = pi/2;
	Mapping = [Mapping CurrentMapping];
	BkGm = gm;
    res = kernel_residualGM(G,KData,gm);
    Res = [res;Res];
    %% Write code to backProject and compute Variances etc;
    %Modes = modesofVariation(Data,Mapping);
    R  = sum(Res.^2,2);
    R = R*100/sum(R);
    QDR=0
    %QDR= estimateQualityDR(Data,eye(num_points,num_points),G,Mapping(1:end),R,options.maxDims);
    %QDR = [QDR;1:num_points];
    Vecs =zeros(size(Mapping(1).v,1),size(Mapping,2));
    for i=1:size(Mapping,2)
        Vecs(:,i) = Mapping(i).v;
    end
    'Rechecking all vectors'
    A = Vecs'*G*Vecs;
    A = A -eye(size(A));
    max(abs(A(:)))
    assert(max(abs(A(:))) < 1E-4, 'Mappings are not perp');
    
end