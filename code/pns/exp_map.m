function point = exp_map(p, v)
%EXP_MAP Computes the exponential map given a point and a direction vector
%p point ko north pole assume karke v ka vector batao 
assert (abs(dot(v,p)) < 1e-3, 'perp error');
assert (abs(1 - norm (p)) < 1e-3,'norm v not equal to one');
norm(v)
point = cos(norm(v)) * p + sin (norm (v)) * (v / max (1e-10, norm(v)));
norm(point)
norm(p)
assert (abs(1 - norm (point))< 1e-3, 'point error');
assert (abs(1 - norm (p)) < 1e-3,'p error');

end

