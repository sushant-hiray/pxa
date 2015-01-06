function [curError] = residualT(TData,v,r)
	V = v(:,ones(1,size(TData,2)));
	curError = TData - V;
	curError = curError.^2;
	temp = ones(1, size(TData,1));
	curError = sqrt(temp*curError) - r;
	curError = sum(curError.^2)/size(TData,2);
end