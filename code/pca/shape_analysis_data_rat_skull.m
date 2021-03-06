function D = shape_analysis_data_rat_skull(shapes,method)

    X = shapes(:,1:8);
    X = X';
    k =size(X);
    Y = shapes(:,9:16);
    Y = Y';
    n = 8;
    no_of_samples =k(2) ;
    
    I = zeros(8:2);
    I(:,1,:) = X;
    I(:,2,:) = Y;
    
    
    meanShape = zeros(n,2);
    Scaled =I;
    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     shapes1 = shapes';
%    
%     X = shapes1(:,1:56);
%     X = X';
%     size(X)
%     Y = shapes1(:,57:112);
%     Y = Y';
%     
%     n = 56;
%     no_of_samples = 40;
%     I = zeros(56:2:40);
%     I(:,1,:) = X;
%     I(:,2,:) = Y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hold on
    for i = 1:no_of_samples,
       plot(I(:,1,i),I(:,2,i),'r+');
    end
    
    meanShape = zeros(n,2);
    Scaled =I;
    
    if (method ==0)
        [meanShape,Scaled] = multi_procrustes(I,n,no_of_samples);
        %plot(meanShape(:,1),meanShape(:,2),'b*');
    elseif(method ==1)
        meanShape = tangent_space_projection(I,n,no_of_samples);
        plot(meanShape(:,1),meanShape(:,2),'b*');
    else
        Y = pca(I,100,n,no_of_samples)
    end
    
    
    %compute the variance 
    [V,D] = pca(meanShape,Scaled,n,no_of_samples);
    [row,col] = find(D == max(abs(D(:))));
    eigenVect1 = V(:,row);
    eigenVect2 = V(:,row-1);
    eigenVect3 = V(:,row-2);
    eigenVect1 = eigenVect1;
    disp('diagonal D');
    %plot(diag(D),'ro-')
    [x,y] = size(D)
    temp = zeros(y,1);
    temp = temp +1;
    temp = D * temp;
    
    print('max eigen value')
    a =max(D(:))
    tem = diag(D);
    eigenVal2 = tem(row-1); 
    eigenVal3 = tem(row-2); 
    %disp('column number is : ' + row);
    eigenDiff = zeros(n,2);
    eigenDiff(:,1) = eigenVect1(1:n);
    eigenDiff(:,2) = eigenVect1(n+1:end);
    
    eigenDiff2 = zeros(n,2);
    eigenDiff2(:,1) = eigenVect2(1:n);
    eigenDiff2(:,2) = eigenVect2(n+1:end);
    eigenDiff3 = zeros(n,2);
    eigenDiff3(:,1) = eigenVect3(1:n);
    eigenDiff3(:,2) = eigenVect3(n+1:end);

    meanShape2 = meanShape - 2*sqrt(a)*eigenDiff;
    meanShape3 = meanShape + 2*sqrt(a)*eigenDiff;
    meanShape4 = meanShape - 2*sqrt(eigenVal2)*eigenDiff2;
    meanShape5 = meanShape + 2*sqrt(eigenVal2)*eigenDiff2;
    meanShape6 = meanShape - 2*sqrt(eigenVal3)*eigenDiff3;
    meanShape7 = meanShape + 2*sqrt(eigenVal3)*eigenDiff3;
    
    figure();
    hold on;
    size(meanShape3);
    plot(meanShape2(:,1),meanShape2(:,2),'g*-');
    plot(meanShape3(:,1),meanShape3(:,2),'m*-');
    plot(meanShape(:,1),meanShape(:,2),'b*-');
    axis equal tight;
    figure();
    hold on;
    plot(meanShape4(:,1),meanShape2(:,2),'k*-');
    plot(meanShape5(:,1),meanShape3(:,2),'r*-');
    plot(meanShape(:,1),meanShape(:,2),'b*-');
    axis equal tight;
    figure();
    hold on;
    size(meanShape3);
    plot(meanShape6(:,1),meanShape6(:,2),'g*-');
    plot(meanShape7(:,1),meanShape7(:,2),'m*-');
    plot(meanShape(:,1),meanShape(:,2),'b*-');
    
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
    plot(meanShape(:,1),meanShape(:,2),'b*-');
    
    figure();
    hold on;
     plot(meanShape(:,1),meanShape(:,2),'b*-');
    for i = 1:no_of_samples,
       plot(Scaled(:,1,i),Scaled(:,2,i),'r*');
    end
    
    axis equal;
    
    figure();
    hold on;
    plot(meanShape(:,1),meanShape(:,2),'b*-');
    
    
    
    
    
    
