function [ pts ] = generate_ptcloud( num_points, noise_scale )

r_ideal = 5;
r1 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
r_ideal = 10;
r2 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
r_ideal = 15;
r3 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
%You'd probably also want a theta:
theta_degrees = 360*rand(num_points,1);

pts1 = [r1.*cos(theta_degrees)];
pts2 = [r1.*sin(theta_degrees)];
pts3 = [r2.*cos(theta_degrees)];
pts4 = [r2.*sin(theta_degrees)];
pts5 = [r3.*cos(theta_degrees)];
pts6 = [r3.*sin(theta_degrees)];
pts = vertcat(pts1,pts2,pts3,pts4,pts5,pts6);
pts = pts';
end

