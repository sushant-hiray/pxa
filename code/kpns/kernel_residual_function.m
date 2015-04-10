function [error] = kernel_residual_function(G,KData,vdagger)
    r=pi/2;
    % KData here is in tangent space for some v0 
    num_points = size(KData,2);
    num_feat = size(KData,1);
    vRep = vdagger(:,ones(1,num_points));
    
    E = KData -vRep;
    normE = E'*G*E;
    normE = sqrt(diag(normE));
    error = sum((normE -r).^2);
    error = error/num_points;
end