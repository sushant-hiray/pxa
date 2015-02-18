function plotTrianglesSpl(Data)
    Y = zeros(4,1);
    X = zeros(4,1);
    for i=1:size(Data,2)
        X(1:2) = Data(2:3,i);
        Y(3) = Data(1,i);
        X(4) = Data(2,i);
        plot(X,Y,'r-');
        hold on;
    end
end