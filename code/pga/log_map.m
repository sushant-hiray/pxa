function vec = log_map(p1, p2)
%LOG_MAP returns the vector in tangent space of p1 in direction of p2

dot_p = dot(p1, p2);
assert(dot_p ~= 1,  '[log_map]: inner product of the parameters cannot be one');
normalize = sqrt(1 - dot_p^2);
vec = ((p2 - dot_p*p1)/normalize)*acos(dot_p);

end

