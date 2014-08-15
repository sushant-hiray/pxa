function mean = plot_mean(n, dim)
%EXP_MAP Computes the exponential map given a point and a direction vector

a = generate_points(n, dim);
mean = geodesic_mean(a, n, 0.3 , 0.0001);
[x,y,z] = sphere(50);
% plotting data
figure
scatter3(a(:,1),a(:,2),a(:,3), 'r+')
hold on
scatter3(mean(1), mean(2), mean(3), 'y*')
hold on
surface(x,y,z,'FaceColor', 'blue','EdgeColor','none')
hold on
% end plot
end