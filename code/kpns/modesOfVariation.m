function [Modes] = modesOfVariation(Data,Mapping)
%% This is the case when r = pi/2    
Modes = Mapping(end).v;
m = size(Mapping,2);
    for i =1:m-1
        v = Mapping(end-i).v;
        e = zeros(size(v));
        e(end) =1;
        rotm = rot(v,e);
        Modes = rotateAll(Modes,rotm);
        Modes = [Modes v];
    end
end