function vec = log_map_old(p1, p2)
%LOG_MAP returns the vector in tangent space of p1 in direction of p2

assert (abs(1 - norm (p1)) < 1e-5, '[log_map]: p1 error');
assert (abs(1 - norm (p2)) <  1e-5,'[log_map]: p2 error');

dot_p = sum (p1.* p2);
%assert(dot_p ~= 1,  '[log_map]: inner product of the parameters cannot be one');
normalize = max (1e-5, sqrt(1 - dot_p^2));
vec = ((p2 - dot_p * p1) / normalize) * acos (dot_p);
%abs(sum(vec.*p1));
%vec 
%p1
%p2;
assert (abs(sum(vec.*p1)) < 1e-2,'perp error');

end

