function [ x_new ] = fk( vk , rk , x )
%fk Move vk to north pole and and scale data
assert(isscalar(rk), '[fk]:rk sould be scalar');
assert(iscolumn(vk), '[fk]: vk should be column vector');
assert(iscolumn(x), '[fk]: x should be column vector');

e_m = zeros(size(vk)); %column vec
l = length(vk);
e_m(l) = 1; %e_m = [0 0  ... 0 1]

r = rot_m(vk, e_m);

r = r(1:l-1,:); %remove the last row


x_new = r*x;
x_new = x_new./sin(rk);
% returns a col vector
end

