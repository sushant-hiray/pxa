rng(0);
PGS =1
Data =  generate_ellipse(100,8);
%Total_R = dim_reduction_data2(Data,'Ellipse Data',1,1);
%Total_R
dim_reduction_sampling(Data,'Ellipse',25,2,0);
