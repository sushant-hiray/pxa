rng(0);
% Data = generate_data2(3,100);
Data = randvonMisesFisherm(3,100, 100, [0 0 1]);


size(Data)
coeff = kernel_karcher_mean(Data);
'coeff is'
size(coeff)
mean1 = (coeff'*Data')';

mean2 = geodesic_mean(Data);
'diff is'
diff = norm(mean1 - mean2)

plot3(Data(1,:), Data(2,:), Data(3,:), 'r*');
hold on;
plot3(mean1(1,:), mean1(2,:), mean1(3,:), 'g*');
hold on;
plot3(mean2(1,:), mean2(2,:), mean2(3,:), 'b*')