function [v] = optimize_for_v(error_f, gradient_f, vInitial )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %implementing gradient descent with adpative step size
    threshold = 1E-5;
    eta = 0.06;
    v = vInitial
    current_val = error_f(v);
    error = 2*threshold;
    prev_val =0;
    prev_error = 2*threshold;
    grad = gradient_f(v);
    prev_val;

    while(abs(prev_val-current_val) > threshold && norm(grad) > threshold && eta > 1E-5)
        prev_val = current_val;
        grad = gradient_f(v);
        v = v - eta*grad;
        current_val = error_f(v);
        if(prev_val > current_val)
            eta = 1.1*eta;
        else
            eta = 0.5*eta;
        end
        current_val;
            
        
    end
    
    'Threshold is ' 
    abs(prev_val-current_val)
    'gradient is '
    norm(grad)
end

