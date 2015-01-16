function [error] = residualVec(Data,v,r)
    
	error = acos(v'*Data) ;
	error = (error -r);
	
end