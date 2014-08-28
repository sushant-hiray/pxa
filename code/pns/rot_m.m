function [ r ] = rot_m(v, e_m)
    %  v is the vector which is to be rotated
    %  e_m is the north pole (0,0,0,...,1)'
    %  r is the rotation matrix
    theta = acos(v'*e_m);
    c = v - e_m*(e_m'*v);
    c = c / max(norm(c), 1e-4);
    A = e_m*c' - c*e_m';
    r = expm(theta*A);
end