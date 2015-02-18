function [error] = residual(Data,v,r)
	error = acos(v'*Data) ;
	error = abs(error -r);
	error = sum(error)/size(Data,2); 
end