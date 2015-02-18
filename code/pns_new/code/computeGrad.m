function [grad] = computeGrad(TData,v,r)
	V = v(:,ones(1,size(TData,2)));
	G = TData -V;
	currentError = sqrt(sum(G.^2,1));
	currentErrorR = currentError-r;
	divisionFactor = currentErrorR./currentError;
	df = divisionFactor(ones(1,size(TData,1)),:);
	size(df);
	G = -G.*df;
	grad = sum(G,2);
end