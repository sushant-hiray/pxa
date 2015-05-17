%% COmments : KPNS > KPCA Guassian kernel 3-4%


load('../../data/iris.mat');
iris = iris(:,1:4);
rng(0);
%iris = normc(iris');
PGS =1;
iris = iris';

TotalSamplings = 5
PointsInIris = size(iris,2);
irisSampled = datasample(iris,ceil(0.8*PointsInIris),2)
Total_Var = computePerVariances(irisSampled,5,'iris');
All_Var = zeros(size(Total_Var,1),size(Total_Var,2),TotalSamplings+1)
All_Var(:,:,end) = Total_Var;
for i=1:TotalSamplings
    irisSampled = datasample(iris,ceil(0.8*PointsInIris),2)
    All_Var(:,:,i)= computePerVariances(irisSampled,5,'iris');
end

All_Var = All_Var(1:10,:,:);
Origin = 1:1:size(All_Var,1);
All_Var2 = zeros(size(All_Var,1)*size(All_Var,3),size(All_Var,2));
Origin = Origin(ones(size(All_Var,1)*size(All_Var,3),1),:);
for i=1:size(All_Var,3)
    for j=1:size(All_Var,2)
        All_Var2((i-1)*size(All_Var,1)+1:i*size(All_Var,1),j) = All_Var(:,j,i);
    end
end


boxplot(reshape(All_Var2(:,1),10,size(All_Var,3))

