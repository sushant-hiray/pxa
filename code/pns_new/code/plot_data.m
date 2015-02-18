function plot_data( X,new_fig )
%   UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    n= size(X,1)/2;
    if(new_fig==1)
        figure;
    end
    X = [X(1:n,:) ; X(1,:);X(n+1:end,:);X(n+1,:)];
    size(X)
    n = n+1;
    for i=1:size(X,2)
           plot(X(1:n,i),X(n+1:end,i),'*-','Color',rand(3,1));
           hold on;
    end
    %plot(X(1:n,1),X(n+1:end,1),'*-','Color',rand(3,1))
    hold off;
    axis equal tight;
end

