function point = exp_map(p, v)
%EXP_MAP Computes the exponential map given a point and a direction vector

point = cos(norm(v))*p + sin(norm(v))*(v/norm(v));

end

