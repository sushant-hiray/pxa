function [Mapping,BkGm,R,NewBPData,Res] = pnsMain(Data, debugMode,mode)
	%% Initialize with null, and start finding the modes of variation 
	Mapping = [];

	data_dim = size(Data,1);
	X = Data;
    Res = [];
    RProd = 1;
    newMode =0;
    lowest_eig = data_dim;
	while data_dim > 2
		v = 0;
        r =0;
        [v,r] = findSphere(X,1,lowest_eig,Mapping);
		CurrentMapping.v = v;
		CurrentMapping.r = r;
		res = residualVec(X,v,r);
        Res = [RProd*res;Res];
        RProd = RProd *sin(r);
        
        Mapping = [Mapping CurrentMapping];
		fprintf('Error at Dim  %d is %f',data_dim,residual(X,CurrentMapping.v,CurrentMapping.r));
        %Residual = [Residual residual(X,CurrentMapping.v,CurrentMapping.r)];
        %Update the Data dimensionality and rotate the data.
        lowest_eig = lowest_eig -1;
		XUpdated = projectData(X,CurrentMapping);
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
    res = residualVecGM(X,gm);
    Res = [RProd*res;Res]
    
    %% Write code to backProject and compute Variances etc;
    %Modes = modesofVariation(Data,Mapping);
    
    R  = sum(Res.^2,2);
    R = R*100/sum(R);
    
    
    
    %% Now compute the variations in shape
    NewPData = applyProjection(Data,Mapping(1:end-1));
    NewBPData = backProject(NewPData,Mapping(1:end-1));
    
    
    % move along the mode of variation
    
    
    
    %%
end