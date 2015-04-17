function [grad] = kernel_grad_function(G,KData,vdagger)
    r=pi/2;
    num_points = size(KData,2);
    num_feat = size(KData,1);
    vRep = vdagger(:,ones(1,num_points));
    
    E = KData -vRep;
    normE = E'*G*E;
    normE = diag(normE);
    normE = (normE<1E-27)*1E-27 + (normE>=1E-27).*normE;
    normE = sqrt(normE');
    error = (normE -r).^2;
    errorRep = error(ones(num_feat,1),:);
    normERep = normE(ones(num_feat,1),:);
    
    grad = -2*E.*errorRep./normERep;
    grad = sum(grad,2);
end