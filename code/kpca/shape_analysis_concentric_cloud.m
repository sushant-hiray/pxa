rng(0);
num_points =  100;
pts = generate_ptcloud(num_points,0);
size(pts)
figure
subplot(2,1,1);
plot(pts(1:2:num_points*2),pts(2:2:2*num_points),'r*');
hold on;
%plot(pts(2*num_points+1:2:4*num_points),pts(2*num_points+2:2:4*num_points),'g*');
%hold on;
% plot(pts(4*num_points+1:5*num_points),pts(5*num_points+1:6*num_points),'b*');
axis equal tight;
grid on;

subplot(2,1,2);
options.KernelType = 'Gaussian';
[ eigvec, eig_val, K] = kpca_main(pts, options);

plot_eig_vec1(pts,eigvec);
axis equal tight;
grid on;
