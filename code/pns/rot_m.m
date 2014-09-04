function [ r ] = rot_m(v, e_m)
    %  v is the vector which is to be rotated
    %  e_m is the north pole (0,0,0,...,1)'
    %  r is the rotation matrix
    size_e_m = size(e_m);
    assert(size_e_m(2) == 1, 'Not a column vector e_m');
    
    size_v = size(v);
    assert(size_v(2) == 1, 'Not a column vector v');
    theta = acos(v'*e_m);
    c = v - e_m*(e_m'*v);
    c = c / max(norm(c), 1e-4);
    A = e_m*c' - c*e_m';
    %'skew symmetric';
   
    r = expm(theta*A);
end