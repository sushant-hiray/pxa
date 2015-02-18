function [X] = applyProjection(Data,Mapping)
    s = size(Mapping,2);
    X = Data;
    for i=1:s
        X = projectData(X,Mapping(i));
    end

end