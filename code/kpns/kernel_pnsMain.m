function [Mapping,BkGm,R,NewBPData,Res] = kernel_pnsMain(Data, debugMode,mode)
	%% Initialize with null, and start finding the modes of variation 
	Mapping = [];

	data_dim = size(Data,1);
	X = Data;
    Res = [];
    RProd = 1;
    newMode =0;
    lowest_eig = data_dim;
    G = generateGramMatrix(Data,'Linear');
    num_points = size(Data,2);
    KData = eye(num_points,num_points);
    kernel_dim = num_points;
    KData = normalizeKernelData(KData,G);
	while data_dim > 2
        [v,r] = kernel_findSphere(G,KData,lowest_eig,Mapping,kerenl_dim);
		CurrentMapping.v = v;
		CurrentMapping.r = r;
% 		res = residualVec(KData,v,r);
%         Res = [RProd*res;Res];
%         RProd = RProd *sin(r);
%         
        Mapping = [Mapping CurrentMapping];
		fprintf('Error at Dim  %d is %f',data_dim,residual(X,CurrentMapping.v,CurrentMapping.r));
        %Residual = [Residual residual(X,CurrentMapping.v,CurrentMapping.r)];
        %Update the Data dimensionality and rotate the data.
       
		KData = kernel_projectData(KData,CurrentMapping);
	    %assert(abs(norm(K(:,1)) -1) <1E-4, 'norm not 1'); 
        kernel_dim = kernel_dim -1;
    end
	%% Find the geodesic mean for the Data
	gm = geodesic_mean(X);
	CurrentMapping.v = gm;
	CurrentMapping.r = pi/2;
	Mapping = [Mapping CurrentMapping];
	BkGm = gm;
    %BkGm = backProject(gm,Mapping(1:end-1));
    res = residualVecGM(X,gm);
    Res = [RProd*res;Res];
    %% Write code to backProject and compute Variances etc;
    %Modes = modesofVariation(Data,Mapping);
    R  = sum(Res.^2,2);
    R = R*100/sum(R);
    %% Now compute the variations in shape
    NewPData = applyProjection(Data,Mapping(1:end-1));
    NewBPData = NewPData;
    %NewBPData = backProject(NewPData,Mapping(1:end-1));
    % move along the mode of variation 
    %%
end