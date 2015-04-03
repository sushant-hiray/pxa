in_dim =3;
Data = randvonMisesFisherm(in_dim,1000, 100, [0 0 1]);
Data(:,1) = zeros(in_dim,1);
Data(end,1) = 1/sqrt(2);
Data(1,1) = 1/sqrt(2);
Data(:,2) = zeros(in_dim,1);
Data(2,2) = 1;
Data(:,3) = zeros(in_dim,1);
Data(1,3) = 1;

G = generateGramMatrix(Data,'Linear');
num_points = size(Data,2);
v = zeros(num_points,1);
v(end) = 1;
KData = eye(num_points);
log_map_Data = kernel_log_map(G,KData,v);
temp = log_map_Data;
TData = Data*temp;
%TData2 = log_map(Data(:,end),Data);
%se =sum((TData(:)-TData2(:)).^2);

exp_map_Data = kernel_exp_map(G,log_map_Data,v);

e = sum((diag(exp_map_Data-eye(num_points))).^2);
FinalData = Data*exp_map_Data;

FinalData2 = exp_map(Data(:,end),TData);

