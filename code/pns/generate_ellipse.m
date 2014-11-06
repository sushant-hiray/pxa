function [ ellipse_data ] = generate_ellipse(no_of_ellipse)
    f_half = [cos(0), cos(pi/4), cos(pi/2), cos(3*pi/4), cos(pi), cos(5*pi/4), cos(3*pi/2), cos(7*pi/4)] ;
    f_half = repmat(f_half,no_of_ellipse,1);
    
    s_half = [sin(0), sin(pi/4), sin(pi/2), sin(3*pi/4), sin(pi), sin(5*pi/4), sin(3*pi/2), sin(7*pi/4)] ;
    s_half = repmat(s_half,no_of_ellipse,1);
    
    a = rand(no_of_ellipse,1);
    b = rand(no_of_ellipse,1);
    a = repmat(a,1,8)
    b = repmat(b,1,8)
    
   
    f_half = f_half.*a;
    s_half = s_half.*b;
    
    f_half = f_half';
    s_half = s_half';
    ellipse_data = [ f_half; s_half];
    ellipse_data = normc(ellipse_data);
end

