function [v,r] = applyLM(X,v)
    % v = Initial Seed Value
    global Data;
    Data = X;
    global r;
    r = pi/2;
    
    
    options = optimoptions(@lsqnonlin,'Algorithm', ['levenberg-marquardt'],'TolFun',1e-3,'TolX',1e-3);
    %currently fix r 
    
    v = v/norm(v);
    'inital error';
    compute_error(v);
    
    
    
    v = lsqnonlin(@(x) compute_error(x),v,[],[],options);
    
    %optimize_for_v(x);
    
    
    'final error';
    
    
    v = v/norm(v);  
    compute_error(v)
   
end




