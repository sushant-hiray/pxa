function plot_eig_vec(pts,eig_vec)
% for now consider the points are
%0 200 on X 
%0 200 on Y
no_of_eig = size(eig_vec,2);
A = zeros(200,200,no_of_eig);
x = zeros(2,1);
for i =1:200
    for j=1:200
        x(1) = (i-100)/10;
        x(2) = (j-100)/10;
        v = zeros(1,size(pts,2));
        for k=1:size(pts,2)
            temp = x-pts(:,k);
            temp2 = x'*pts(:,k);
            %v(k) = exp(-(temp'*temp))/2;
            v(k) = temp2;
            %v(k) = (temp2+1)^2;
            %v(k) = (temp2)^2;
        end
        for l=1:no_of_eig
            A(j,i,l) = abs(v*eig_vec(:,l));
        end
    end
end
imshow(mat2gray(A));

end