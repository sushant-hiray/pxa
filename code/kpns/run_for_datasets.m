
% BAD
%dim_reduction_breast_tissue 
%dim_reduction_spect
%dim_reduction_yacht

% good frac_var


% good BOTH
%dim_reduction_forestfire % sigmaFactor 0.5, nPolyDegree 13, percentage 70
%dim_reduction_blood % sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_vc % sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_gi % sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_mnist_3% sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_mnist_1% sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_mnist_8% sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_cancer % sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_liver % sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_wine % sigmaFactor 0.5, nPolyDegree 13, percentage 70  % good QR

return

dim_reduction_leaf % sigmaFactor 0.5, nPolyDegree 18, percentage 70
dim_reduction_seeds % sigmaFactor 0.5, nPolyDegree 4, percentage 70
dim_reduction_fertility % sigmaFactor 0.7, nPolyDegree 4, percentage 70
dim_reduction_planningrelax % sigmaFactor 1.4, nPolyDegree 8, percentage 70
dim_reduction_cb % sigmaFactor 1, nPolyDegree 13, percentage 70
dim_reduction_parkinsons % sigmaFactor 0.5, nPolyDegree 23, percentage 70
dim_reduction_iris% sigmaFactor 0.5, nPolyDegree 33, percentage 70 as you increase the poly degreee the shift increases

% good QR
dim_reduction_concreteslump % sigmaFactor 0.5, nPolyDegree 20, percentage 70 % good QR
dim_reduction_wine % sigmaFactor 0.5, nPolyDegree 13, percentage 70  % good QR
dim_reduction_haberman % sigmaFactor 0.8, nPolyDegree 13, percentage 70 % good QR 

% Done
dim_reduction_yale % sigmaFactor 0.9, nPolyDegree 13, percentage 70
dim_reduction_ecoli % sigmaFactor 0.5, nPolyDegree 13, percentage 70
dim_reduction_usps % sigmaFactor 0.5, nPolyDegree 5, percentage 70

return

% Not performing good
dim_reduction_sonar 
dim_reduction_ellipse
