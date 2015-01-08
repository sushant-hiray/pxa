function  [Y,Scaled] = multi_procrustes(I,n,no_of_samples)
	d = 1;
	Z = zeros(n,2,no_of_samples);
    
    Z =I;
    
    base = I(:,:,1);
    prevbase = ones(n,2);
    j=1;
    while(j<2)
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
        
    
        for i = 1:no_of_samples,
            rotated = rotate(mean_sample,Z(:,:,i),muX,normX,n);
            d = 1;
            Z(:,:,i) = rotated;
        end;
        
        
        
        % should update the new mean now
        prevbase = base;
        base  = Z(:,:,1);
        j=j+1;
    end
    Y = mean(Z,3);
    Scaled = Z;
    

function z = center(X)
    [a, b]   = size(X);
    muX = mean(X,1);
    z = X - repmat(muX, a, 1);
    ssqI = sum(z.^2,1);
    ssqI = sum(ssqI);
    normI = sqrt(ssqI);
    z = z / normI ;
    
function z = rotate(base,Y0,muX,normX,n)
	A = double(base') * Y0;

	% Singular Value Decomposition
	[L, D, M] = svd(A);
	T = M * L';


	z = normX * Y0 * T + double(repmat(muX, n, 1));
