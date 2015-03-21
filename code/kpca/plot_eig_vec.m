function plot_eig_vec(pts,eig_vec)
% for now consider the points are
%0 200 on X 
%0 200 on Y
no_of_eig = size(eig_vec,2);
A = zeros(200,200,no_of_eig);
x = zeros(2,1);

R = 1:200;
R = R(ones(200,1),:);
C = R;

R = R';
R =R(:);
R=R';

C = C(:);
C =C';
X = [R;C];
X = (X -100)/10;


%% Exponential Kernel
ptsTiled = repmat(pts,1,size(X,2));
XTiled = repmat(X,1,size(pts,2));
V = ptsTiled-XTiled;

V = exp(-(Y.^2))/2;

%%

A = eig_vec' * V;



imshow(mat2gray(A));


end