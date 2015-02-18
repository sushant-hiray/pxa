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
    Data = X;
    %Data = cellfun(@(x)(log_map(x, v0)), num2cell(X, 1),'UniformOutput',false);
    %Data = cell2mat(Data);
    threshold = 0.001;
    %size(v0)
    'inital error'
    compute_error2(1E-5*rand(data_dim,1))
 
    
    %%% Need to initialize v0 and v1 etc %%%
    
    DataProj = cellfun(@(x)(log_map(v0, x)), num2cell(X,1),'UniformOutput',false);
    DataProj = cell2mat(DataProj);
    
    v = mean(DataProj,2);
    v = zeros(size(v));
    v1 =v;
    
    %v1 =v0
    %v = v0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    prevV1 = 0;
    prev_val = compute_error2(v);
    curr_val = compute_error2(1E-5*rand(data_dim,1));
    forcedContinue = true;
    while(forcedContinue || (norm(v1) > threshold && abs(norm(v1)-norm(prevV1)) > 0.1*threshold && abs(curr_val -prev_val) > 1E-2 ))
        forcedContinue = false;
        prevV1= v1;
        prev_val = curr_val;
        % replace with gradient Descent
        % v = lsqnonlin(@(x) compute_error2(x),v,[],[],options);
        v = optimize_for_v(@(x) compute_error2(x), @(x)gradient_error_fun(x),v);
        
        
        %optimize_for_v(x);
        
        v0 =normc(v0);
        v1=v-(dot(v,v0)/norm(v0))*v0;
        %v1 =v;
        %v1 = v1/norm(v1);
        %v1 = v1 - v0* dot(v1,v0)/norm(v0)
        %dot(v1,v0);
        v0 = exp_map(v0,v1);
%        v0 =normc(v0);
        curr_val = compute_error2(1E-5*rand(data_dim,1));
        curr_val
        %'norm v1 ';
        %norm(v1);
       
    end
    'final error'
    compute_error2(1E-5*rand(data_dim,1));
    v = v0;
end

function [vprime] = jacobian(v)
    vprime = zeros(v);
    vprime = Data -repmat(v,size(Data,2));
    A = (vprime > 0)*ones(size(Data,2));
    A = 2*A -1
    vprime = vprime - A
end




