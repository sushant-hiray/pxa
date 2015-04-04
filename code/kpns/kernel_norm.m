function [ norm ] = kernel_norm( G, data )

norm = sqrt(diag(data'*G*data));

end

