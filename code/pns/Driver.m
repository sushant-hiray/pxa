
dim = 8;
rng(0);
mu = rand(dim,1);


%mu = zeros(dim,1);
%mu(dim) = 1;
mu = normc(mu);
SIGMA = ones(dim,1);
SIGMA = 0.05*SIGMA;

X = make_gaussian_data(mu,SIGMA',2000);

[Mapping, X_pns,X_BackErr,Modes,gm,Var] = pns(X);

gm16 = gm;
mu16 = mu;
geodesic16 = geodesic_mean(X);