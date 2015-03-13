rng(0);
num_points = 50;
pts = generate_ptcloud(num_points,1);
size(pts)
figure
subplot(2,1,1);
plot(pts(1:num_points),pts(num_points+1:2*num_points),'r*');
hold on;
plot(pts(2*num_points+1:3*num_points),pts(3*num_points+1:4*num_points),'g*');
hold on;
plot(pts(4*num_points+1:5*num_points),pts(5*num_points+1:6*num_points),'b*');


subplot(2,1,2);
options.KernelType = 'Gaussian';
[ eigvec, eig_val, data_out ] = kpca_main(pts, options);
size(eigvec)
plot(data_out(1:num_points),data_out(num_points+1:2*num_points),'r*');
hold on;
plot(data_out(2*num_points+1:3*num_points),data_out(3*num_points+1:4*num_points),'g*');
hold on;
plot(data_out(4*num_points+1:5*num_points),data_out(5*num_points+1:6*num_points),'b*');



