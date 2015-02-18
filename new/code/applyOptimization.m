function [center, r] = applyOptimization(Data,V0,itype)
	r = pi/2; % initialValue
	center = V0;
	size(center);
	error = residual(Data,center,r);

	% Average can never be greater than 2*pi
	prevError = 2*pi;
	alpha = 1E-5; % this referred to as alpa in the act
    d =size(Data,1);
	Data_mapped = log_map(center,Data);
    %[center r] = LMFsphereFit(Data_mapped,zeros(d,1),itype);
    
	while(abs(prevError - error)/abs(error)  > alpha )
		% First map the data to tangent space by using log_map w.r.t to the give V0
		errorMsg1=  '[apply Optimization Center undefined incorrectly no lying on a shpere of radius 1]';
		assert(abs(center' *center -1) < 1E-3,  errorMsg1);
		Data_mapped = log_map(center,Data);
        'optimizie v r'
        
		[vdagger rdagger]  = optimizeforvr(Data_mapped, itype);
        'end optimize v r'
		vdagger = vdagger - (vdagger'*center)*center;
		center = exp_map(center,vdagger);
		size(center);
		r = rdagger;
		prevError= error;
		error = residual(Data,center,r);
        error
		%disp(['current Error ' error]);		
    end
    
end