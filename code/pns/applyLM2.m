function [v,r] = applyLM2(X,vInitial)
    % v = Initial Seed Value
    
    global r;
    r = pi/2;
    global Data;
    data_dim = size(X,1); 
    options = optimoptions(@lsqnonlin,'Algorithm', ['levenberg-marquardt'],'TolFun',1e-3,'TolX',1e-3);
    %currently fix r 
    global v0;
    v0 = vInitial;
    v0 = v0/norm(v0);
    Data = cellfun(@(x)(log_map(x, v0)), num2cell(X, 1),'UniformOutput',false);
    Data = cell2mat(Data);
    threshold = 0.0001;
    %size(v0)
    'inital error';
    compute_error2(1E-5*rand(data_dim,1));
    
    v = v0;
    v1 =v0;
    prevV1 = 0;
    while(norm(v1) > threshold && abs(norm(v1)-norm(prevV1)) > threshold)
        v = lsqnonlin(@(x) compute_error2(x),v,[],[],options);
        %optimize_for_v(x);
        v0 =normc(v0);
        
        v1=v-(dot(v,v0)/norm(v0))*v0;
        %v1 = v1/norm(v1);
        %v1 = v1 - v0* dot(v1,v0)/norm(v0)
        dot(v1,v0);
        v0 = exp_map(v0,v1);
        prevV1= v1;
       
    end
    'final error';
    compute_error2(1E-5*rand(data_dim,1));
    v = v0;
end




