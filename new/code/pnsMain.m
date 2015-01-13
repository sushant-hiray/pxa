function [Mapping,BkGm,Var,R] = pnsMain(Data, debugMode,mode)
	%% Initialize with null, and start finding the modes of variation 
	Mapping = [];

	data_dim = size(Data,1);
	X = Data;
    Res = [];
	while data_dim > 2
		[v,r] = findSphere(X,mode);
		CurrentMapping.v = v;
		CurrentMapping.r = r;
		res = residualVec(X,v,r);
        
        Res = [res;Res];
        
        Mapping = [Mapping CurrentMapping];
		fprintf('Error at Dim  %d is %f',data_dim,residual(X,CurrentMapping.v,CurrentMapping.r));
        %Residual = [Residual residual(X,CurrentMapping.v,CurrentMapping.r)];
        %Update the Data dimensionality and rotate the data.
		XUpdated = projectData(X,CurrentMapping);
		assert(size(X,1)-size(XUpdated,1) ==1, 'dimensionality reduction not successful');
        assert(abs(norm(X(:,1)) -1) <1E-4, 'norm not 1'); 
		X = XUpdated;
		data_dim = data_dim -1;
    end
    
	%% Find the geodesic mean for the Data
	gm = geodesic_mean(X);
	CurrentMapping.v = gm;
	CurrentMapping.r = pi/2;
	Mapping = [Mapping CurrentMapping];
	BkGm = backProject(gm,Mapping(1:end-1));
    res = residualVec(X,gm,0);
    Res = [res;Res]
    
    %% Write code to backProject and compute Variances etc;
    %Modes = modesofVariation(Data,Mapping);
    Var = computeVariances(Data,Mapping);
    'Variances computed'
    Var
    R  = sum(Res.^2,2);
    R = R*100/sum(R);
    
end