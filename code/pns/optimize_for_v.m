function [v] = optimize_for_v(error_f, gradient_f, vInitial )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %implementing gradient descent with adpative step size
    threshold = 1E-3;
    global v0;
    eta = 0.06/1000;
    v = vInitial
    current_val = error_f(v);
    error = 2*threshold;
    prev_val =0;
    prev_error = 2*threshold;
    grad = gradient_f(v);
    prev_val;
    forcedContinue = false;
    while((forcedContinue || abs(prev_val-current_val)/abs(current_val) > threshold) && eta > 1E-8)
        forcedContinue = false;
        temp_val = prev_val;
        prev_val = current_val;
        grad = gradient_f(v);
        grad=grad-(dot(grad,v0)/norm(v0))*v0;
        assert(grad'*v0 < 1E-4 , 'grad projection not working');
        
        v = v - eta*grad;
        
        current_val = error_f(v);
        if(prev_val > current_val)
            eta = 1.1*eta;
        else
            v = v + eta*grad;
            forcedContinue = true;
            current_val = prev_val;
            prev_val = temp_val;
            eta = 0.5*eta;
        end
        current_val
            
        
    end
    
    'Threshold is ' 
    abs(prev_val-current_val)
    'gradient is '
    norm(grad)
end

