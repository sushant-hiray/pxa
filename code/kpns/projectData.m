function [X] = projectData(Data,Map)
	%Step1 : Rotate data so that Map.v becomes north pole.
    
    phoxv = log_map(Map.v,Data);
    phoxv = phoxv.^2;
    phoxv = sqrt(sum(phoxv,1));
    phoxv = phoxv(ones(size(Data,1),1),:);
    v = Map.v;
    Vrep =v(:,ones(1,size(Data,2)));
	NewData = (sin(Map.r)*Data + sin(phoxv - Map.r).*Vrep);
    NewData = NewData./sin(phoxv);
    X = NewData;
    
    %e = zeros(size(NewData,1),1);
	%e(end) = 1;
	%rotationMatrix = rot(e,Map.v);
	%X = rotateAll(NewData,rotationMatrix);
	%Step2: Project all the data on the circle.
	norm(X(:,1))
    
end