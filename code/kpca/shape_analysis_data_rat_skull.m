load('../../data/ratskullData.mat');
rng(0);
shapes = A;
X = shapes(:,1:2:end);
X = X';
k =size(X);
Y = shapes(:,2:2:end);
Y = Y';
n = 8;
no_of_samples =k(2) ;

I = zeros(8:2);
I(:,1,:) = X;
I(:,2,:) = Y;
size(I)
%{
figure();
for i = 1:no_of_samples
     i
    temp1 = I(:,1,i);
    temp2 = I(:,2,i);
     plot(temp1(:),temp2(:),'*-','Color',rand(3,1));
     hold on;
end
%}
axis equal tight

meanShape = zeros(n,2);
Scaled =I;

[meanShape,Scaled] = multi_procrustes(I,n,no_of_samples);
meanShape = meanShape(:);
scaled_pcaInput = zeros(no_of_samples,n*2);
for i =1:no_of_samples
    temp = Scaled(:,:,i);
    scaled_pcaInput(i,:) = temp(:);
    scaled_pcaInput(i,1:n) = scaled_pcaInput(i,1:n) - mean(scaled_pcaInput(i,1:n)); 
    scaled_pcaInput(i,n+1:end) = scaled_pcaInput(i,n+1:end) - mean(scaled_pcaInput(i,n+1:end)); 
    norm_scaled = norm(scaled_pcaInput(i,:));
    scaled_pcaInput(i,:) = scaled_pcaInput(i,:)/norm_scaled;

end
assert(abs(mean(scaled_pcaInput(1,1:n))) <= 1E-15, 'mean error ');
assert(abs(mean(scaled_pcaInput(1,n+1:end))) <= 1E-15, 'mean error ');



subplot(1,2,1)
plot_rat_skull(scaled_pcaInput',0);
axis equal tight;
hold on;
options.KernelType = 'PolyPlus'
[ eigvec, eig_val ] = kpca_main(scaled_pcaInput',options);
100*eig_val/sum(eig_val)

% subplot(1,2,2)
% plot_rat_skull(BkGm,0);
% axis equal tight;
% hold on;
% plot_rat_skull_same(NewBPData,0);