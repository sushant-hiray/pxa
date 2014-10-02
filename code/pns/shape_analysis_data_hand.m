function [MComp, Xpns, XBackErr] = shape_analysis_data_hand(shapes)

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
   
    
    figure()
    hold on
    
    for i = 1:no_of_samples,
       plot(I(:,1,i),I(:,2,i),'g+');
    end
    
    plot(meanShape(1:n),meanShape(n+1:end),'r*-');
    axis equal tight;
    hold on;
    
    %compute the variance
    [MComp,Xpns, XBackErr] = pns(scaled_pcaInput');
    backProjectGm = backProject(MComp(end).v, MComp(1:(end-1)));
    plot(backProjectGm(1:n),backProjectGm(n+1:end),'b*-')
end