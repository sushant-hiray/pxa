function [ Output ] = backProject( Input, T  )
%   function projects data(Input) through a series of transformations to
%   the highest layer
    tempInput = Input;
    isempty(T);
    noOfPoints  = size(Input,2);
    size(T);
    'nilesh';
    T;
    while isempty(T)==0
        ImmTrans = T(end); %struct of v and r
        dim = size(tempInput,1);
%       'current input dim'
%       dim
        cosrRow = ones(1,noOfPoints);
        cosrRow = cosrRow*cos(ImmTrans.r);

        tempInput = sin(ImmTrans.r)*tempInput;
        tempInput = [tempInput; cosrRow];
        
        e_m = zeros(1,dim+1);
        e_m(dim+1) = 1;
        e_m = e_m';
        
        v = ImmTrans.v;
%{
        v = v';
        'fkdjshkfhdsk'
        size(v)
        size(e_m)
        'fhdkjsh'
        iscolumn(v)
        iscolumn(e_m)
%}
        rotationMat = rot_m(e_m,v);
        tempInput = rotate_data(tempInput,rotationMat);
        T = T(1:end-1);
        'completed iteration'
    end
    Output =tempInput;
    
end