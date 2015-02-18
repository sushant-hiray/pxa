function [center, r] = findSphere(Data, rtype) 
%type =0 r not fixed to pi/2
%type =1 r = pi/2

dim = size(Data,1);
%X_corr = Data * Data';

%[U D] = eigs(X_corr); % gives the smallest EigenValue Vector
[U dd] = svd(Data);

V = U(:,end);


%{
if(dim==3)
    V = [-0.8042     0.5879   -0.0879]';
   
elseif (dim == 4)
    V = [-0.8764     0.1507   -0.2505   -0.3828]';
    
elseif (dim == 5)
    V = [  -0.3553     0.8185     0.0836    -0.3115   -0.3159]'
else
    V = V;
end
%}

V = normc(V);
%V(:) =0; V(end)=1;
% Now start applying gradient descent with the objective function to
% optimize for v and r depending upon the parameter type

% Initialization happens using V as the intial value of V0

if (rtype == 1)
% r=pi/2
	r=pi/2;
    
	center = applyOptimization(Data,V,rtype);
elseif (rtype ==0)
	[center r] = applyOptimization(Data,V,rtype);
% r!=pi/2
end



end