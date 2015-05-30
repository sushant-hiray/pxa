function [ kmean ] = kernel_karcher_mean(G,KData,Mapping)
% Computes the karcher Mean of the data points using gradient descent

num_points = size(KData, 2);
assert(num_points ~= 0,  '[kernel_karcher_mean]: No of Samples cannot be zero');
threshold = 1E-3;
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
kmean = kmean / sqrt(kmean'*G*kmean);

while (1)
%'---------------------------------------------------------------'
    tangentSpace_data = kernel_log_map(G, KData, kmean);
    objOld = mean(diag(tangentSpace_data'*G*tangentSpace_data));
    
    gradient = mean (tangentSpace_data, 2);
    
    dotPs = gradient'*G*Vecs;
    dotPsRep = dotPs(ones(size(Vecs,1),1),:);
    gradient = gradient - sum(Vecs.*dotPsRep,2);
    
    % new mean
    kmean = kernel_exp_map(G,step_size*(gradient), kmean);
    
    % relative change
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
