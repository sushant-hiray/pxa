
dim = 3;
rng(0);
%mu = [ -1.0000    1.0000         0   -0.1667   -0.1667    0.3333]'
%mu = rand(dim,1);
mu = [0 0 1]'

%mu = zeros(dim,1);
%mu(dim) = 1;
mu = normc(mu);
SIGMA = rand(dim,1);
SIGMA = 0.01*SIGMA;
SIGMA = [0.2 0.04 0.04]'
X = make_gaussian_data(mu,SIGMA',1000);

[Mapping, X_pns,X_BackErr,Modes,gm,Var] = pns(X,0);

gm16 = gm;
mu16 = mu;
geodesic16 = geodesic_mean(X);