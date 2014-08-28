function point = exp_map(p, v)
%EXP_MAP Computes the exponential map given a point and a direction vector
assert (abs(dot(v,p)) < 1e-5, 'perp error');
point = cos(norm(v)) * p + sin (norm (v)) * (v / max (1e-5, norm(v)));
assert (abs(1 - norm (point))< 1e-5, 'point error');
assert (abs(1 - norm (p)) < 1e-5,'p error');

end

