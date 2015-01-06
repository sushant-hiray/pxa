function [TData] =log_map(v,Data)
    1-norm(v)
	assert (abs(1 - norm (v)) < 1e-4    , '[log_map]: v error');
	%assert (abs(1 - norm (p2)) <  1e-5,'[log_map]: p2 error');
	V = v(:,ones(1,size(Data,2)));
    
	dot_P = v'*Data;
    dot_P = (dot_P >1)*1;
	oneMinusDotP = 1 - dot_P.^2;
	oneMinusDotP = (oneMinusDotP<0)*0; 
    oneMinusDotP = sqrt(oneMinusDotP);
    oneMinusDotP = (oneMinusDotP > 1E-5).*oneMinusDotP + (oneMinusDotP<1E-5)*1E-5;
	
	dotPRep = dot_P(ones(size(Data,1),1),:);
	oneMinusDotPRep = oneMinusDotP(ones(size(Data,1),1),:);

	TData = ((Data - V.*dotPRep)./oneMinusDotPRep).*acos(dotPRep);
	assert (mean(abs(v'*TData)) < 1e-2,'perp error');
end 