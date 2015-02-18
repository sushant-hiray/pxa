function [ X ] = generateData(v,r,n )
    dim =size(v,1);
    X = zeros(dim,n); 
    for i=1:n
        X(dim,i) = cos(r);
        rest = rand(1,dim-1)-0.5    ;
        rest = rest';
        rest = (sin(r)/norm(rest))*rest;
        X(1:dim-1,i) = rest;
    end
    X = normc(X);
end

