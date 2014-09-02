function [v,r] = applyLM(X)
    global Data;
    Data = X;
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global r;
    r = pi/2;
    
    options = optimoptions(@lsqnonlin,'Algorithm', ['levenberg-marquardt']);
    %currently fix r 
    [n,dim] =  size(X);
    v = rand(dim,1);
    v = v/norm(v)
    v = v'
    'inital error'
    compute_error(v)
    v = lsqnonlin(@(x) compute_error(x),v,[],[],options);
    'final error'
    v = v/norm(v);  
    compute_error(v)
   
end



