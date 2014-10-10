function  Y = tangent_space_projection(I,n,no_of_samples)
	% array fun
	d = 1;
	Z = zeros(n,2,no_of_samples);
    
    Z =I;
    
    base = I(:,:,1);
    prevbase = ones(n,2);
    j=0;
    while(j<4)
        muX = mean(base,1);
        ssqX = sum(base.^2,1);
        ssqX = sum(ssqX);
        normX = sqrt(ssqX);

        % centering and normalising the data
        for i = 1:no_of_samples,
            centered = center(Z(:,:,i));
            d = 1;
            Z(:,:,i) = centered;
        end;

        mean_sample = Z(:,:,1);

        for i = 2:no_of_samples,
            rotated = rotate(mean_sample,Z(:,:,i),muX,normX,n);
            d = 1;
            Z(:,:,i) = rotated;
        end;
        % should update the new mean now
        prevbase = base;
        base  = Z(:,:,1);
        disp(j);
        j=j+1;
    end
    Y = Z(:,:,2);
    % now make all vectors to lie on the tangent space
    T = zeros(2*n,no_of_samples);
    temp = Z(:,:,i);
    temp =temp(:);
    T(:,1) = temp';
    for i = 2:no_of_samples,
        temp  =Z(:,:,i);
        temp = temp(:);
        T(:,i) = temp';
        alpha = (mean(T(:,1))^2)/((T(:,1)'* T(:,i)));
        T(:,i) =  alpha* T(:,i);
    end
    Y = mean (T,2);
    [Y,padded] = vec2mat(Y,2);
    
    
    
   
    
    

function z = center(X)
    [a, b]   = size(X);
    muX = mean(X,1);
    z = X - repmat(muX, a, 1);
    ssqI = sum(X.^2,1);
    ssqI = sum(ssqI);
    normI = sqrt(ssqI);
    z = z / normI ;

function z = rotate(base,Y0,muX,normX,n)
	A = double(base') * Y0;

	% Singular Value Decomposition
	[L, D, M] = svd(A);
	T = M * L';


	z = normX * Y0 * T + double(repmat(muX, n, 1));
