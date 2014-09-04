function [ x_new ] = fk( vk , rk , x )
%fk Move vk to north pole and and scale data
assert(isscalar(rk), 'rk sould be scalar')
e_m = zeros(size(vk));
l = length(vk(:,1));
e_m(l) = 1;
r = rot_m(vk, e_m);
r = r(1:l-1,:);
% x is row vect
'x';
size(x);
'r';
size(r);
x_new = r*x;
x_new = x_new.*sin(rk);
% returns a row vector 
x_new = x_new';
size(x_new) ;
end

