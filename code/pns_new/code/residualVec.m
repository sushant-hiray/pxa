function [error] = residualVec(Data,v,r)
	error = acos(v'*Data) -r ;
end