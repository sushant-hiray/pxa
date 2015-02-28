    function [v,r] = optimizeforvr(TData, Itype)
	initialV = zeros(size(mean(TData,2)));
    %initialV = mean(TData,2);
	initialR = pi/2;
    if(Itype ==0)
        m = mean(TData,2);
        M = m(:,ones(1,size(TData,2)));
		curUpdate = M -TData;
        curUpdate = curUpdate.^2;		
		curUpdate = sum(sqrt(sum(curUpdate,1)))/size(TData,2);
        initialR = curUpdate;    
        initialV = m;
    end
    gradient = computeGrad(TData,initialV,initialR);
	currentResidual = residualT(TData,initialV,initialR);
	prevResidual = 2*pi;
	alpha = 1E-6;
	v = initialV;
    % debug
    %v(:) = 0; v(end) = 1;
	r = initialR;
	stepSize = 1e-3;
	currentOverall = currentResidual;
	prevOverall = prevResidual;
    AllRes = currentResidual;
	while (abs(currentOverall - prevOverall)/abs(prevOverall) > alpha)
		while(abs(currentResidual-prevResidual) > alpha)
			gradient = computeGrad (TData,initialV,r);
			v = v - stepSize * gradient;
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
            if stepSize <alpha*1E-1
                break
            end
            AllRes = [AllRes currentResidual];
        end

    
		if(Itype == 1)
		% r is pi/2
			r =pi/2;
            prevOverall = currentOverall;
            currentOverall = residualT(TData,v,r);
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