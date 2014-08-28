function [ out ] = f_inv( vk, rk, x )
% x belongs to S(d-k)
assert(isscalar(rk), 'rk sould be scalar')
e_m = zeros(size(vk));
l = length(vk(:,1));
e_m(l) = 1;
r = rot_m(vk, e_m);
r = r';
vec = [x.*sin(rk), cos(rk)]
out = r*vec;
end

