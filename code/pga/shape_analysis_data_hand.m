function shape_analysis_data_hand(shapes)

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
    
    
    %compute the variance
    [meanShape,V,D] = pga(scaled_pcaInput);
    
    [eigenValue1,row] = max(diag(D));
    eigenVect1 = V(:,row);
    
    a = max(diag(D));
    meanShape2 = - 2*sqrt(a)*eigenVect1';
    meanShape3  = + 2*sqrt(a)*eigenVect1';
    
    meanShape2 = exp_map(meanShape,meanShape2);
    meanShape3 = exp_map(meanShape, meanShape3);
   
    figure();
    hold on;
    plot(meanShape2(1:n),meanShape2(n+1:end),'g*-');
    plot(meanShape3(1:n),meanShape3(n+1:end),'m*-');
    plot(meanShape(1:n),meanShape(n+1:end),'b*-');
    axis equal tight;
    
    
    [row,col] = find(D == max(abs(D(:))));
    
    eigenVect2 = V(:,row-1);
    eigenVect3 = V(:,row-2);
    
    meanShape4 = - 2*sqrt(a)*eigenVect2';
    meanShape5  = + 2*sqrt(a)*eigenVect2';
    meanShape4 = exp_map(meanShape,meanShape4);
    meanShape5 = exp_map(meanShape, meanShape5);
    
    
    figure();
    hold on;
    plot(meanShape4(1:n),meanShape4(n+1:end),'g*-');
    plot(meanShape5(1:n),meanShape5(n+1:end),'m*-');
    plot(meanShape(1:n),meanShape(n+1:end),'b*-');
    axis equal tight;
    
    meanShape6 = - 2*sqrt(a)*eigenVect3';
    meanShape7  = + 2*sqrt(a)*eigenVect3';
    meanShape6 = exp_map(meanShape,meanShape6);
    meanShape7 = exp_map(meanShape, meanShape7);
    
    figure();
    hold on;
    plot(meanShape6(1:n),meanShape6(n+1:end),'g*-');
    plot(meanShape7(1:n),meanShape7(n+1:end),'m*-');
    plot(meanShape(1:n),meanShape(n+1:end),'b*-');
    axis equal tight;
    
    
    figure();
    hold on;
    for i=1:3,
        for j=1:3
            if i ==3 && j==3
                continue;
            end
            subplot(3,3,(i-1)*3+j)
            plot(Scaled(:,1,i),Scaled(:,2,i),'r*-')
            axis equal;
        end
    end
    subplot(3,3,9);
    plot(meanShape(1:n),meanShape(n+1:end),'b*-');
    