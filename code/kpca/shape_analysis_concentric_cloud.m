rng(0);
num_points = 100;
pts = generate_ptcloud(num_points,1);
figure
subplot(2,1,1);
plot(pts(1,1:num_points),pts(2,1:num_points),'r*');
hold on;
plot(pts(1,num_points+1:2*num_points),pts(2,num_points+1:2*num_points),'g*');
hold on;
plot(pts(1,2*num_points+1:3*num_points),pts(2,2*num_points+1:3*num_points),'b*');


subplot(2,1,2);
options.KernelType = 'Gaussian';
[ eigvec, eig_val, data_out ] = kpca_main(pts, options);
plot(data_out(1,1:num_points),'r*');
hold on;
plot(data_out(1,num_points+1:2*num_points),data_out(2,num_points+1:2*num_points),'g*');
hold on;
plot(data_out(1,2*num_points+1:3*num_points),data_out(2,2*num_points+1:3*num_points),'b*');



