load('../../data/shapedata.mat');

shapes = digit3;
n = 13;
no_of_samples =size(shapes,3) ;

I = zeros(n:2);
I(:,1,:) = shapes(:,1,:);
I(:,2,:) = shapes(:,2,:);
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
plot_three(scaled_pcaInput',0);
axis equal tight;
hold on;

PGS =1;
[Mapping, BkGm,Res,NewBPData,AllRes] = pnsMain(scaled_pcaInput',1,PGS);

subplot(1,2,2)
plot_three(BkGm,0);
axis equal tight;
hold on;
plot_three_same(NewBPData,0);