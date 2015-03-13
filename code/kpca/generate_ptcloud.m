function [ pts ] = generate_ptcloud( num_points, noise_scale )

r_ideal = 5;
r1 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
% r_ideal = 10;
% r2 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
% r_ideal = 15;
% r3 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
%You'd probably also want a theta:
theta_degrees = (0:2*pi/(num_points-1):2*pi);
%theta_degrees = theta_degrees';
num_points
size(theta_degrees)
pts1 = r_ideal*cos(theta_degrees');
pts2 = r_ideal*sin(theta_degrees');

% pts3 = [r2.*cos(theta_degrees)];
% pts4 = [r2.*sin(theta_degrees)];
% pts5 = [r3.*cos(theta_degrees)];
% pts6 = [r3.*sin(theta_degrees)];
% pts = vertcat(pts1,pts2,pts3,pts4,pts5,pts6);
% pts = vertcat(pts1,pts2,pts3,pts4);
pts = [pts1  pts2];
pts = pts';
%pts = pts(:);
end

