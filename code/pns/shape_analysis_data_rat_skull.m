function [MComp, Xpns,XBackErr,Modes,Var,gm] = shape_analysis_data_rat_skull( shapes )
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
    %{
    for i = 1:no_of_samples,
       plot(I(:,1,i),I(:,2,i),'g+');
    end
    %}
    plot(scaled_pcaInput(1,1:n),scaled_pcaInput(1,n+1:end),'r*-');
    axis equal tight;
    hold on;
    
    %compute the variance
    [Mapping, X_pns,X_BackErr,Modes,gm,Var] = pns(scaled_pcaInput');
    backProjectGm = backProject(MComp(end).v, MComp(1:(end-1)));
    plot(backProjectGm(1:n),backProjectGm(n+1:end),'b*-')
    gm = backProjectGm;
    'hi';

end

