    function [v,r] = optimizeforvr(TData, Itype)
	initialV = zeros(size(mean(TData,2)));
	initialR = pi/2;
	gradient = computeGrad(TData,initialV,initialR);
	currentResidual = residualT(TData,initialV,initialR);
	prevResidual = 2*pi;
	alpha = 1E-2;
	v = initialV;
	r = initialR;
	stepSize = 1E-3;
	currentOverall = currentResidual;
	prevOverall = prevResidual;
    
	while (abs(currentOverall - prevOverall)/abs(prevOverall) > alpha)
		while(abs(currentResidual-prevResidual) > alpha)
			gradient = computeGrad(TData,initialV,r); 
			v = v - stepSize*gradient;
			newResidual = residualT(TData,v,r);
			if(newResidual > currentResidual)
				stepSize = stepSize/2; % reduce gradient rate.
				v = v + stepSize*gradient;
			else
				prevResidual =currentResidual;
				currentResidual = newResidual;
				stepSize = stepSize*1.1; %increase gradient rate;
            end	
            %stepSize
            if stepSize <alpha
                break
            end
        end

        
		if(Itype == 1)
		% r is pi/2
			r =pi/2;
            prevOverall = currentOverall;
            currentOverall = residualT(TData,v,r)
			break;
		else
			V = v(:,ones(1,size(TData,2)));
			currUpdate = V -TData;
			temp = ones(1, size(TData,1));
			curUpdate = sum(sqrt(temp*curUpdate));
			r = curUpdate;
            prevOverall = currentOverall;
            currentOverall = residualT(TData,v,r)
        end
		
	end
end