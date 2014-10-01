function [ Output ] = backProject( Input, T  )
%UNTITLED Summary of this function goes here
%   function projects data(Input) through a series of transformations to
%   the highest layer
    tempInput =Input;
    isempty(T)
    while isempty(T)==0
        'here'
        ImmTrans = T(1);
        noOfPoints  = size(Input,2)
        dim = size(tempInput,1);
        cosrRow = ones(1,noOfPoints);
        cosrRow = cosrRow*cos(ImmTrans.r);
        size(cosrRow)
        size(tempInput)
        tempInput = sin(ImmTrans.r)*Input;
        tempInput = [tempInput;cosrRow];
        'afd'
        size(tempInput)

        % now rotate the data
        'dim'
        dim
        e_m = zeros(1,dim+1);
        e_m(dim+1) = 1;
        e_m = e_m';
        v = ImmTrans.v;
        v = v';
        size(v)
        size(e_m)
        rotationMat = rot_m(e_m,v);
        size(tempInput)
        tempInput = rotate_data(tempInput,rotationMat)
        T = T(2:end);
    end
    Output =tempInput;
    
end