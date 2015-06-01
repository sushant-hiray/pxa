function [ kmean ] = kernel_karcher_mean(G,KData,Mapping)
% Computes the karcher Mean of the data points using gradient descent

num_points = size(KData, 2);
assert(num_points ~= 0,  '[kernel_karcher_mean]: No of Samples cannot be zero');
threshold = 1E-2;
step_size = 0.1;
assert(threshold < 1,  '[kernel_karcher_mean]: Threshold should be less than 1');

delta = 0.001;

% initial mean = average of data
kmean = mean(KData,2);
assert(sqrt(kmean'*G*kmean) > 1E-2, 'Kmean inital is zero');
kmean  = kmean / sqrt (kmean'*G*kmean);

%
if(size(Mapping,2)  > 0)
    Vecs = getVecsFromMapping(Mapping);
end

dotPs = kmean'*G*Vecs;
dotPsRep = dotPs(ones(size(Vecs,1),1),:);
kmean = kmean - sum(Vecs.*dotPsRep,2);
kmean = kmean / max (1e-5, sqrt(max(kmean'*G*kmean,1E-20)));
meanChange = 1;
while(1)
%while (meanChange > 1E-3)
%'---------------------------------------------------------------'
    tangentSpace_data = kernel_log_map(G, KData, kmean);
    tangentSpace_data(:,1)
    objOld = mean(diag(tangentSpace_data'*G*tangentSpace_data));
    
    gradient = mean (tangentSpace_data, 2);
    
    dotPs = gradient'*G*Vecs;
    dotPsRep = dotPs(ones(size(Vecs,1),1),:);
    gradient = gradient - sum(Vecs.*dotPsRep,2);
    
    %gradient should also be perp to kmean
    gradient = gradient - (kmean'*G*gradient)*kmean;    
    % new mean
    gradient'*G*kmean
    prevKmean = kmean;
    kmean = kernel_exp_map(G,step_size*(gradient), kmean);
    meanChange = kernel_log_map(G,kmean, prevKmean);
    fprintf('mean change norm %f\n' ,meanChange'*G*meanChange);
    fprintf('mean and Mapping dot products %f\n',max(max(abs(Vecs'*G*kmean))))
    '-----'
    fprintf('Squared Norm updated kmean %f \n',kmean'*G*kmean)
    if(abs(kmean'*G*kmean -1 )>=1E-4)
      error ('********************************* mean norm NOT 1 ********************************************************');
    end
    % relative change
    kmean = kmean / max (1e-5, sqrt(max(kmean'*G*kmean,1E-21)));
    tangentSpace_data = kernel_log_map(G, KData, kmean);
    objNew = mean(diag(tangentSpace_data'*G*tangentSpace_data));
    
    if (abs (objNew - objOld) / objOld < 1e-6)
       break
    end
end
%'================================================================== '
tangentSpace_data = kernel_log_map(G, KData, kmean);
objFinal = mean(diag(tangentSpace_data'*G*tangentSpace_data));
'================================================================== ';

return
