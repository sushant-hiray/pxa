function [Bx] = backProject(Data,Mapping)
    maps = size(Mapping);
    i = maps(2);
    tempInput = Data;
    while(i>0)
        i
        currentTrans = Mapping(i);
        r = currentTrans.r;
        v = currentTrans.v;
        tempInput = tempInput*sin(r);
        newComp = ones(1,size(Data,2));
        newComp = cos(r)*newComp;
        tempInput = [tempInput; newComp];
        e = zeros(size(v));
        e(end) =1;
        rotm = rot(v,e);
        tempInput = rotateAll(tempInput,rotm);
        i = i-1;
    end
    %Bx= tempInput;
    Bx = Data;
end