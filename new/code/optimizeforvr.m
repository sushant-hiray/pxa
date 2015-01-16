    function [v,r] = optimizeforvr(TData, Itype)
	initialV = zeros(size(mean(TData,2)));
	initialR = pi/2;
    if(Itype ==0)
        initialR = pi/3;
    end
    gradient = computeGrad(TData,initialV,initialR);
	currentResidual = residualT(TData,initialV,initialR);
	prevResidual = 2*pi;
	alpha = 1E-4;
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
			curUpdate = V -TData;
            curUpdate = curUpdate.^2;
			
			curUpdate = sum(sqrt(sum(curUpdate,1)))/size(TData,2);
			r = curUpdate;
            prevOverall = currentOverall;
            currentOverall = residualT(TData,v,r);
        end
		
	end
end