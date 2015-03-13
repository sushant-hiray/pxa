function [ pts ] = generate_ptcloud( num_points, noise_scale )

r_ideal = 5;
r1 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
r_ideal = 10;
r2 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
r_ideal = 15;
r3 = r_ideal+(rand(num_points,1)-.5)*noise_scale; %r_ideal = ideal radius; noise_scale= deviation
%You'd probably also want a theta:
theta_degrees = 360*rand(num_points,1);

pts1 = [r1.*cos(theta_degrees), r1.*sin(theta_degrees)];
pts2 = [r2.*cos(theta_degrees), r2.*sin(theta_degrees)];
pts3 = [r3.*cos(theta_degrees), r3.*sin(theta_degrees)];
pts = vertcat(pts1,pts2,pts3);
pts = pts';
end

