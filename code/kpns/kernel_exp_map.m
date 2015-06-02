
function [Out] = kernel_exp_map(G,KData,v0)
% exp map of KData w.r.t. v0
  
  num_points = size(KData,2);
  num_feat  = size(KData,1);
  
  D = sqrt (max (diag (KData'*G*KData),1E-20));
  %D = sqrt(diag(KData'*G*KData));
  D = D';
  D = D(ones(num_feat,1),:);
  sinD = sin(D);
  cosD = cos(D);
  % D = (D> 1E-10).*D + (D<=1E-10)*1E-10;
  D = max (1e-10, D);
  bRep = v0(:,ones(1, num_points));
  Out = cosD .* bRep + KData .* (sinD./ max (1e-6,D));
  
  %if max (diag (abs(Out'*G*Out - 1))) >= 1E-5
  %  diag (abs(Out'*G*Out - 1))
  %end
  assert(max (diag (abs(Out'*G*Out - 1))) < 1E-4, 'error in exp map');
end
