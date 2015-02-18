function [ p ] = projection(normal_vec , angle , x)
    %  sub-sphere is defined by the normal vec and the angle it makes with the normal.
    %  x is the point to be projected
    %  p is the projected point
    phoD = norm(log_map(normal_vec , x));
    p   = (sin(angle)*x + sin(phoD - angle)*normal_vec)/sin(phoD);
end