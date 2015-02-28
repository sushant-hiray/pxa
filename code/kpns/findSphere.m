function [center, r] = findSphere(Data, rtype,singular_value,prevMapping) 
%type =0 r not fixed to pi/2
%type =1 r = pi/2

	dim = size(Data,1);
	%X_corr = Data * Data';
	%[U D] = eigs(X_corr); % gives the smallest EigenValue Vector
	[U dd] = svd(Data);

	V = U(:,singular_value);

	V = normc(V);
	%V(:) =0; V(end)=1;
	% Now start applying gradient descent with the objective function to
	% optimize for v and r depending upon the parameter type
	% Initialization happens using V as the intial value of V0

	if (rtype == 1)
		r=pi/2;
	   	center = applyOptimization(Data,V,rtype,prevMapping);
	elseif (rtype ==0)
		[center r] = applyOptimization(Data,V,rtype);
	end
end