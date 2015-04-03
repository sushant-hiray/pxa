function [Out] = kernel_exp_map(G,KData,v0)
    num_points = size(KData,2);
    num_feat  = size(KData,1);
    D = sqrt(diag(KData'*G*KData));
    D = D';
    D = D(ones(num_feat,1),:);
    sinD = sin(D);
    cosD = cos(D);
    D = (D> 1E-10).*D + (D<1E-10)*1E-10;
    bRep = v0(:,ones(1, num_points));
    Out = cosD.*bRep+ KData.*(sinD./D);
end