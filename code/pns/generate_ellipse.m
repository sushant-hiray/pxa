function [ ellipse_data ] = generate_ellipse(no_of_ellipse,N)
    theta = 0:2*pi/(N):2*pi
    theta = theta(1:end-1);
    f_half = cos(theta);
    f_half = repmat(f_half,no_of_ellipse,1);
    
    s_half = sin(theta);
    s_half = repmat(s_half,no_of_ellipse,1);
    
    a = rand(no_of_ellipse,1);
    b = rand(no_of_ellipse,1);
    a = repmat(a,1,N)
    b = repmat(b,1,N)
    
   
    f_half = f_half.*a;
    s_half = s_half.*b;
    
    f_half = f_half';
    s_half = s_half';
    ellipse_data = [ f_half; s_half];
    ellipse_data = normc(ellipse_data);
end

