function [MComp, Xpns,XBackErr,Modes,Var,gm,gm1] = shape_analysis_data_rat_skull( shapes )
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
    
     for i = 1:no_of_samples
         i
        temp1 = I(:,1,i);
        temp2 = I(:,2,i);
         plot(temp1(:),temp2(:),'*-','Color',rand(3,1));
         hold on;
     end
    axis equal tight
    figure();
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
    
    
    
    figure()
    hold on
    
    for i = 1:no_of_samples,
        plot(scaled_pcaInput(i,1:n),scaled_pcaInput(i,n+1:end),'*-','Color',rand(3,1));
    end
    %plot(scaled_pcaInput(1,1:2:end),scaled_pcaInput(1,2:2:end),'r*-');
    axis equal tight;
    hold on;
    
    
    %{
    for i = 1:no_of_samples,
        plot(B(i,1:n),B(i,n+1:end),'*-','Color',rand(3,1));
        hold on;
    end
    %}
    
    
    %compute the variance
    [MComp, Xpns,XBackErr,Modes,gm,Var] = pns(scaled_pcaInput',0);
    %backProjectGm = backProject(MComp(end).v, MComp(1:(end-1)));
    plot(gm(1:n),gm(n+1:end),'k+-','LineWidth' , 5 );
    %gm = backProjectGm;
    gm1= geodesic_mean(scaled_pcaInput');
    axis equal tight;
    
    'hi';

end

