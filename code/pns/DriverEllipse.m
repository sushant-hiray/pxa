
no_of_samples = 10;
n = 8

[ shapes] = generate_ellipse(no_of_samples,8);
shapes = shapes'
X = shapes(:,1:n);
X = X';
k =size(X);
Y = shapes(:,n+1:end);
Y = Y';
n = 8;
no_of_samples =k(2) ;

I = zeros(8:2);
I(:,1,:) = X;
I(:,2,:) = Y;

[meanShape,Scaled] = multi_procrustes(I,n,no_of_samples);

meanShape = meanShape(:);

scaled_pcaInput = zeros(no_of_samples,n*2);

for i =1:no_of_samples
    temp = Scaled(:,:,i);
    scaled_pcaInput(i,:) = temp(:);
    norm_scaled = norm(scaled_pcaInput(i,:));
    scaled_pcaInput(i,:) = scaled_pcaInput(i,:)/norm_scaled;
end

 for i = 1:no_of_samples,
        plot(scaled_pcaInput(i,1:n),scaled_pcaInput(i,n+1:end),'*-','Color',rand(3,1));
        hold on;
 end
 
 axis equal tight;
 
 [Mapping, X_pns,X_BackErr,Modes,gm,Var] = pns(scaled_pcaInput',0);

geodesic16 = geodesic_mean(scaled_pcaInput);

