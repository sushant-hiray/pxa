function plot_data( X,n,new_fig )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if(new_fig==1)
        figure;
    end
    
    for i=1:size(X,2)
           plot(X(1:n,i),X(n+1:end,i),'*-','Color',rand(3,1));
           hold on;
    end
    hold off;

end

