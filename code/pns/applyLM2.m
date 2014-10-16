function [v,r] = applyLM2(X,vInitial)
    % v = Initial Seed Value
    
    global Data;
    Data = X;
    global r;
    r = pi/2; %currently fix r
    Data = X;
    options = optimoptions(@lsqnonlin,'Algorithm', 'levenberg-marquardt','TolFun',1e-5,'TolX',1e-5);
    
    data_dim = size(X,1);
    
    global v0;
    v0 = vInitial;
    v0 = v0/norm(v0);
    
    
    threshold = 0.01;
    'inital error'
    compute_error2(1E-5*rand(data_dim,1))
    
    %v = rand(size(v0));
    %v1 =rand(size(v0));
    v = mean(X,2);
    v1 = mean(X,2);
    size(v);
    prevV1 = 0;
    try1 = 1;
    while((try1==1 ) || (norm(v1) > threshold && abs(norm(v1)-norm(prevV1)) > 0.1*threshold))
        prevV1= v1;
        v = lsqnonlin(@(x) compute_error2(x),v,[],[],options);
        try1=0;
        v0 =normc(v0);
        v1=v-(dot(v,v0)/norm(v0))*v0;
        %v1 =v;
        %v1 = v1/norm(v1);
        %v1 = v1 - v0* dot(v1,v0)/norm(v0)
        %dot(v1,v0);
        v0 = exp_map(v0,v1);
        v0 =normc(v0);
       
    end
    'final error'
    compute_error2(1E-5*rand(data_dim,1));
    v = v0;
end




