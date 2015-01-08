

shapes1 = shapes';

X = shapes1(:,1:56);
X = X';
k =size(X);
Y = shapes1(:,57:112);
Y = Y';

n = 56;
no_of_samples =k(2) ;

I = zeros(56:2:no_of_samples);
I(:,1,:) = X;
I(:,2,:) = Y;


meanShape = zeros(n,2);
Scaled =I;


[meanShape,Scaled] = multi_procrustes(I,n,no_of_samples);
meanShape = meanShape(:);
scaled_pcaInput = zeros(no_of_samples,n*2);
for i =1:no_of_samples
    temp = Scaled(:,:,i);
    scaled_pcaInput(i,:) = temp(:);
    norm_scaled = norm(scaled_pcaInput(i,:));
    scaled_pcaInput(i,:) = scaled_pcaInput(i,:)/norm_scaled;
end


shapes1 = shapes';

X = shapes1(:,1:56);
X = X';
k =size(X);
Y = shapes1(:,57:112);
Y = Y';

n = 56;
no_of_samples =k(2) ;

I = zeros(56:2:no_of_samples);
I(:,1,:) = X;
I(:,2,:) = Y;


meanShape = zeros(n,2);
Scaled =I;


[meanShape,Scaled] = multi_procrustes(I,n,no_of_samples);
meanShape = meanShape(:);
scaled_pcaInput = zeros(no_of_samples,n*2);
for i =1:no_of_samples
    temp = Scaled(:,:,i);
    scaled_pcaInput(i,:) = temp(:);
    norm_scaled = norm(scaled_pcaInput(i,:));
    scaled_pcaInput(i,:) = scaled_pcaInput(i,:)/norm_scaled;
end

subplot(1,2,1)
plot_hand(scaled_pcaInput',0);
axis equal tight;
hold on;
subplot(1,2,2)
[Mapping, BkGm, Var] = pnsMain(scaled_pcaInput',1);
plot_hand(BkGm,0);
%plot(scaled_pcaInput(1,1:2:end),scaled_pcaInput(1,2:2:end),'r*-');
axis equal tight;
hold on;
