function [ V ] = find_modes_of_variation(Mapping)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% currently implementing it for Greater Spheresd
% start completing the basis recursively

    no_of_modes= size(Mapping,2);
    % dimension of vectors = size(Mapping(end).v,2)
    gm = Mapping(end).v;
    assert(size(gm,1) ==2, 'geodesic mean should have size 2');
    V = [gm];
    noOfMappings = size(Mapping,2);
    perp_gm = [-gm(2),gm(1)]'; 
    V = [V perp_gm];
    for i=noOfMappings-1:1
        new_zeros = size(V,2)
        augment_zeros = zeros(1,new_zeros);
        V = [V;augment_zeros]
        dim = size(V,1)
        new_v  = zeros(dim,1)
        new_v(end) = 1;
        V = [V  new_v];
        % no rotate this basis to Mapping(i).v
        size(Mapping(i).v)
        rotationMat = rot_m(new_v, Mapping(i).v);
        V = rotate_data(V,rotationMat);
    end
end

