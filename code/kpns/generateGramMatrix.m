function K_center = generateGramMatrix(data_in,KernelType)
K = zeros(size(data_in,2),size(data_in,2));
for row = 1:size(data_in,2)
    for col = 1:row
        switch lower(KernelType)
            case {lower('Gaussian')}        %  e^{-(|x-y|^2)/2t^2
                temp = sum(((data_in(:,row) - data_in(:,col)).^2));
                K(row,col) = exp(-temp)/(2*sigma*sigma);
            case {lower('PolyPlus')}      % (x'*y + 1)^d
                d = 2;
                K(row,col) = (data_in(:,row)'*data_in(:,col) + 1)^d;
            case {lower('Polynomial')}      % (x'*y)^d
                d = 2;
                K(row,col) = (data_in(:,row)'*data_in(:,col))^d;
            case {lower('Linear')}      % x'*y
                K(row,col) = data_in(:,row)'*data_in(:,col);
            otherwise
                error('KernelType does not exist!');
        end            
    end
end
K = K + K';
%K  = K + 0.01*eye(size(K));
% Dividing the diagonal element by 2 since it has been added to itself
for row = 1:size(data_in,2)
   K(row,row) = K(row,row)/2;
end
% center the gram matrix so that the mean in feature space is also zero
%one_mat = ones(size(K))./size(data_in,2);
%K_center = K - one_mat*K - K*one_mat + one_mat*K*one_mat;
K_center = K;
%clear K;
end