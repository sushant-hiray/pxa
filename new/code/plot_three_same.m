function plot_three_same( X,new_fig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if(new_fig==1)
        figure;
    end
    
    for i=1:size(X,2)
           plot(X(1:13,i),X(13+1:end,i),'y.');
           hold on;
    end
    hold off;

end

