function [ norm ] = kernel_norm( G, data )

size(G)
size(data)
norm = sqrt(diag(data'*G*data));

end

