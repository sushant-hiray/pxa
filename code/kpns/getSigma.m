function sigma = getSigma(Data)
    sumsq=0;
    num_points = size(Data,2);
    A = zeros(num_points,num_points);
    for i =1:num_points
        for j =1:i-1
            A(i,j) = norm(Data(:,i) - Data(:,j))^2;
            sumsq =sumsq + A(i,j);
        end
    end
    A = A + A';
    sumsq = 2*sumsq/((num_points)*(num_points-1));
    sigma = sqrt(sumsq);
end