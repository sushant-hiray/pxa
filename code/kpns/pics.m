
clear all
close all
scrsz = get(0,'ScreenSize');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% classification: digits
clear all
close all
scrsz = get(0,'ScreenSize'); scrsz (3) = scrsz (3) / 2;
%
load ~/Shape/KPCAS/Results/Classify/Digits/spectrumDigit.mat
%
n = 20
figure('Position',scrsz);
plot ( [1:n], sF (1:n) / sum (sF), 'b-*', ...
       [1:n], sL (1:n) / sum (sL), 'r-o', ...
       'LineWidth', 4, 'MarkerSize', 30 )
axis tight, grid on
legend ('Eigen Spectrum with kPCAs', 'Eigen Spectrum with kPCA', 'Location', 'North');
set (gca,'FontSize',50);
xlabel ('Index');
ylabel ('Eigen Value');
% pause
export_fig ~/Shape/KPCAS/Results/Classify/digitsSpectrum.png -a2
close

% classification: digits
clear all
close all
scrsz = get(0,'ScreenSize'); scrsz (3) = scrsz (3) / 2;
%
load ~/Shape/KPCAS/Results/Classify/Digits/digitsSvmGraph.mat
%
errorAllKPCA  = 100 * errorAllKPCA;
errorAllKPCAs = 100 * errorAllKPCAs;
%
figure('Position',scrsz);
plot ( dimensionAll, errorAllKPCAs, 'b*-', ...
       dimensionAll, errorAllKPCA , 'ro-', ...
       'LineWidth', 4, 'MarkerSize', 30 )
axis tight, grid on
legend ('Error Rate with kPCAs', 'Error Rate with kPCA', 'Location', 'North');
set (gca,'FontSize',50);
xlabel ('Number of Dimensions Selected');
ylabel ('Error Rate (in percent)');
% pause
export_fig ~/Shape/KPCAS/Results/Classify/digitsErrorRate.png -a2
close



% classification using discriminative learning : points on hyperspheres: kernel = dot product
clear all
close all
scrsz = get(0,'ScreenSize'); % scrsz (3) = scrsz (3) / 2;
                             %
load ~/Shape/KPCAS/Results/Classify/ptsOnSphereSvmGraph.mat
%
errorAll = [ errorAllKPCA(:,1:5) errorAllKPCAs(:,1:5) ];
errorAll (:,1:2:end) = errorAllKPCA  (:,1:5);
errorAll (:,2:2:end) = errorAllKPCAs (:,1:5);
%
figure('Position',scrsz);
set (gca,'FontSize',100);
bp = boxplot ( errorAll, 'positions', [ 1 1.3  2 2.3  3 3.3  4 4.3  5 5.3 ], 'symbol', '', ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 10);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 10);
grid on
xlabel ('Separability of Classes');
ylabel ('Classification Error Rate');
set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
pause
export_fig ~/Shape/KPCAS/Results/Classify/ptsOnSphereErrorRate.png -a2
close



% classification using generative learning : points on hyperspheres: kernel = dot product
clear all
close all
scrsz = get(0,'ScreenSize'); scrsz (3) = scrsz (3) / 2;
%
load ~/Shape/KPCAS/Results/Classify/PtsOnSphereForML.mat
%
errorAllKPCA  = squeeze (errorRate (1,:,:))'; errorAllKPCA  = [ errorAllKPCA  zeros(size(errorAllKPCA ,1),1) ];
errorAllKPCAs = squeeze (errorRate (2,:,:))'; errorAllKPCAs = [ errorAllKPCAs zeros(size(errorAllKPCAs,1),1) ];
%
errorAll = [ errorAllKPCA errorAllKPCAs ];
errorAll (:,1:2:end) = errorAllKPCA;
errorAll (:,2:2:end) = errorAllKPCAs;
errorAll = 100 * errorAll;
%
figure('Position',scrsz);
set (gca,'FontSize',50);
bp = boxplot ( errorAll, 'positions', [ 1 1.4  2 2.4  3 3.4  4 4.4  5 5.4 ], 'symbol', '', ...
               'widths',    0.35 * ones(1,10), ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 5);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 5);
legend (findobj (gca, 'Tag', 'Box'), 'kPCAs', 'kPCA')
grid on
xlabel ('Separability of Classes');
ylabel ('Error Rate (in percent)');
set (findobj (gca, 'Type', 'text'), 'FontSize', 50)
% pause
export_fig ~/Shape/KPCAS/Results/Classify/ptsOnSphereErrorRate.png -a2
close



% classification using discriminative learning: points on circles: kernel = Gaussian
clear all
close all
scrsz = get(0,'ScreenSize');

load ~/Shape/KPCAS/Results/Classify/ptsOnCircleSvmGraph.mat
%
errorAll = [ errorAllKPCA(:,1:5) errorAllKPCAs(:,1:5) ];
errorAll (:,1:2:end) = errorAllKPCA  (:,1:5);
errorAll (:,2:2:end) = errorAllKPCAs (:,1:5);
%
figure('Position',scrsz);
set (gca,'FontSize',100);
bp = boxplot ( errorAll, 'positions', [ 1 1.3  2 2.3  3 3.3  4 4.3  5 5.3 ], 'symbol', '', ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 10);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 10);
grid on
xlabel ('Separability of Classes');
ylabel ('Classification Error Rate');
set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
pause
export_fig ~/Shape/KPCAS/Results/Classify/ptsOnCircleErrorRate.png -a2
close



% classification using generative learning : points on circles: kernel = Gaussian
clear all
close all
scrsz = get(0,'ScreenSize'); scrsz (3) = scrsz (3) / 2;
%
load ~/Shape/KPCAS/Results/Classify/PtsCircleForML.mat
%
errorAllKPCA  = squeeze (errorRate (1,:,:))'; errorAllKPCA  = [ errorAllKPCA  zeros(size(errorAllKPCA ,1),1) ];
errorAllKPCAs = squeeze (errorRate (2,:,:))'; errorAllKPCAs = [ errorAllKPCAs zeros(size(errorAllKPCAs,1),1) ];
%
errorAll = [ errorAllKPCA errorAllKPCAs ];
errorAll (:,1:2:end) = errorAllKPCA;
errorAll (:,2:2:end) = errorAllKPCAs;
errorAll = 100 * errorAll;
%
figure('Position',scrsz);
set (gca,'FontSize',50);
bp = boxplot ( errorAll, 'positions', [ 1 1.4  2 2.4  3 3.4  4 4.4  5 5.4 ], 'symbol', '', ...
               'widths',    0.35 * ones(1,10), ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 5);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 5);
legend (findobj (gca, 'Tag', 'Box'), 'kPCAs', 'kPCA')
grid on
xlabel ('Separability of Classes');
ylabel ('Classification Error Rate');
set (findobj (gca, 'Type', 'text'), 'FontSize', 50)
% pause
export_fig ~/Shape/KPCAS/Results/Classify/ptsOnCircleErrorRate.png -a2
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clustering: points on hyperspheres

clear all
close all
scrsz = get(0,'ScreenSize'); % scrsz (3) = scrsz (3) / 2;
                             %
load ~/Shape/KPCAS/Results/Cluster/PtsOnSphereGMMEM.mat
%
errorRateKPCA  = 1 - squeeze (result (1,:,:))';
errorRateKPCAs = 1 - squeeze (result (2,:,:))';
%
errorRateAll = [ errorRateKPCA errorRateKPCAs ];
errorRateAll (:,1:2:end) = errorRateKPCA;
errorRateAll (:,2:2:end) = errorRateKPCAs;
errorRateAll = errorRateAll;
%
figure('Position',scrsz);
set (gca,'FontSize',100);
bp = boxplot ( errorRateAll, 'positions', [ 1 1.4  2 2.4  3 3.4  4 4.4  5 5.4 ], 'symbol', '', 'notch', 'off', ...
               'widths',    0.35 * ones(1,10), ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 5);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 5);
legend (findobj (gca, 'Tag', 'Box'), 'kPCAs', 'kPCA')
grid on
xlabel ('Separability of Classes');
ylabel ('Clustering Error Rate');
set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
pause
export_fig ~/Shape/KPCAS/Results/Cluster/ptsOnSphereClustering.png -a2
close

% clustering: points on circles

clear all
close all
scrsz = get(0,'ScreenSize');

% load ~/Shape/KPCAS/Results/Cluster/PtsCircleGMMEMv2.mat
% load ~/Shape/KPCAS/Results/Cluster/PtsCircleGMMEMv3.mat
load ~/Shape/KPCAS/Results/Cluster/PtsCircleGMMEMv4.mat
%
errorRateKPCA  = 1 - squeeze (result (1,:,:))'; % errorRateKPCA  = [ errorRateKPCA  zeros(size(errorRateKPCA ,1),1) ];
errorRateKPCAs = 1 - squeeze (result (2,:,:))'; % errorRateKPCAs = [ errorRateKPCAs zeros(size(errorRateKPCAs,1),1) ];
                                                %
errorRateAll = [ errorRateKPCA errorRateKPCAs ];
errorRateAll (:,1:2:end) = errorRateKPCA;
errorRateAll (:,2:2:end) = errorRateKPCAs;
errorRateAll = errorRateAll;
%
figure('Position',scrsz);
set (gca,'FontSize',100);
bp = boxplot ( errorRateAll, 'positions', [ 1 1.4  2 2.4  3 3.4  4 4.4 ], 'symbol', '', 'notch', 'off', ...
               'widths',    0.35 * ones(1,10), ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 5);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 5);
legend (findobj (gca, 'Tag', 'Box'), 'kPCAs', 'kPCA')
grid on
xlabel ('Separability of Classes');
ylabel ('Clustering Error Rate');
set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
pause
export_fig ~/Shape/KPCAS/Results/Cluster/ptsOnCircleClustering.png -a2
close

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% testing: points on hyperspheres

clear all
close all
scrsz = get(0,'ScreenSize'); % scrsz (3) = scrsz (3) / 2;
                             % load ~/Shape/KPCAS/Results/Testing/PtsOnSphereHypothesisTesting.mat
load ~/Shape/KPCAS/Results/Testing/ptsHyperSphereHypothesis.mat
%
pValueKPCA  = squeeze (result (1,1:6:30,:))';
pValueKPCAs = squeeze (result (2,1:6:30,:))';
%
pValueAll = [ pValueKPCA pValueKPCAs ];
pValueAll (:,1:2:end) = pValueKPCA;
pValueAll (:,2:2:end) = pValueKPCAs;
%
figure('Position',scrsz);
set (gca,'FontSize',100);
bp = boxplot ( pValueAll, 'symbol', '', 'notch', 'off', 'whisker', 0.3, ...
               'positions', [ 1 1.4  2 2.4  3 3.4  4 4.4  5 5.4 ], ...
               'widths',    0.35 * ones(1,10), ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 5);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 5);
legend (findobj (gca, 'Tag', 'Box'), 'kPCAs', 'kPCA')
grid on
xlabel ('Separability of Classes');
ylabel ('Testing p-value');
set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
pause
export_fig ~/Shape/KPCAS/Results/Testing/ptsOnSphereTesting.png -a2
close

% testing: points on circles

clear all
close all
scrsz = get(0,'ScreenSize'); % scrsz (3) = scrsz (3) / 2;
                             %
load ~/Shape/KPCAS/Results/Testing/PtsCircleHypothesisTestingV2.mat
%
pValueKPCA  = squeeze (pValue (1,1:5,:))';
pValueKPCAs = squeeze (pValue (2,1:5,:))';
%
pValueAll = [ pValueKPCA pValueKPCAs ];
pValueAll (:,1:2:end) = pValueKPCA;
pValueAll (:,2:2:end) = pValueKPCAs;
%
figure('Position',scrsz);
set (gca,'FontSize',100);
bp = boxplot ( pValueAll, 'positions', [ 1 1.4  2 2.4  3 3.4  4 4.4  5 5.4 ], 'symbol', '', 'notch', 'off', 'whisker', 0.3, ...
               'widths',    0.35 * ones(1,10), ...
               'Labels', {'0', '0', '1', '1', '2', '2', '3', '3', '4', '4'} );
set (bp (:,1:2:end), 'color', 'r', 'linewidth', 5);
set (bp (:,2:2:end), 'color', 'b', 'linewidth', 5);
legend (findobj (gca, 'Tag', 'Box'), 'kPCAs', 'kPCA')
grid on
xlabel ('Separability of Classes');
ylabel ('Testing p-value');
set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
pause
export_fig ~/Shape/KPCAS/Results/Testing/ptsOnCircleTesting.png -a2
close

% testing : UCI data

clear all
close all
scrsz = get(0,'ScreenSize'); % scrsz (3) = scrsz (3) / 2;

load ~/Shape/KPCAS/Results/Testing/hypothesis_haberman.mat
%
load ~/Shape/KPCAS/Results/Testing/hypothesis_longsphere_wine.mat
load ~/Shape/KPCAS/Results/Testing/hypothesis_longsphere_more_data.mat
%
load ~/Shape/KPCAS/Results/Testing/hypothesis_ecoli.mat
load ~/Shape/KPCAS/Results/Testing/hypothesis_iris.mat
%
%load ~/Shape/KPCAS/Results/Testing/hypothesis_sonar.mat
%load ~/Shape/KPCAS/Results/Testing/hypothesis_sonar_more_data.mat
load ~/Shape/KPCAS/Results/Testing/hypothesis_sonar_more_sets.mat
%
load ~/Shape/KPCAS/Results/Testing/hypothesis_blood.mat
load ~/Shape/KPCAS/Results/Testing/hypothesis_heart.mat

for caseNum = 7 : 8
  switch caseNum
    case 1
      errorkPCA = haberman.kPCA;   errorkPCAs = haberman.kPCAs;   filenamePic = '~/Shape/KPCAS/Results/Testing/testHaberman.png'
    case 2
      errorkPCA = longsphere.kPCA; errorkPCAs = longsphere.kPCAs; filenamePic = '~/Shape/KPCAS/Results/Testing/testIonosphere.png'
    case 3
      errorkPCA = wine.kPCA;       errorkPCAs = wine.kPCAs;       filenamePic = '~/Shape/KPCAS/Results/Testing/testWine.png'
    case 4
      errorkPCA = ecoli.kPCA;      errorkPCAs = ecoli.kPCAs;      filenamePic = '~/Shape/KPCAS/Results/Testing/testEcoli.png'
    case 5
      errorkPCA = iris.kPCA;       errorkPCAs = iris.kPCAs;       filenamePic = '~/Shape/KPCAS/Results/Testing/testIris.png'
    case 6
      errorkPCA = sonar.kPCA;      errorkPCAs = sonar.kPCAs;      filenamePic = '~/Shape/KPCAS/Results/Testing/testSonar.png'
    case 7
      errorkPCA = blood.kPCA;      errorkPCAs = blood.kPCAs;      filenamePic = '~/Shape/KPCAS/Results/Testing/testBlood.png'
    case 8
      errorkPCA = heart.kPCA;      errorkPCAs = heart.kPCAs;      filenamePic = '~/Shape/KPCAS/Results/Testing/testHeart.png'
    otherwise
      error ('');
  end
  
  dimAll = [ 1 : length(errorkPCA) ];
  figure('Position',scrsz); set (gca,'FontSize',100);
  plot ( dimAll, errorkPCAs, 'bo-', ...
         dimAll, errorkPCA , 'ro-', ...
         'LineWidth', 4, 'MarkerSize', 30 )
  grid on; axis tight;
  legend ('kPCAs', 'kPCA')
  xlabel ('Dimension of Subspace Chosen');
  ylabel ('Testing Error Rate');
  set (findobj (gca, 'Type', 'text'), 'FontSize', 100)
  pause
  export_fig (filenamePic, '-a2')
  close
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UCI datasets: Clustering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
scrsz = get(0,'ScreenSize'); scrsz (3) = scrsz (3) * 0.90;

load ~/Shape/KPCAS/Results/Cluster/clustering_haberman_blood.mat
load ~/Shape/KPCAS/Results/Cluster/clustering_heart.mat
load ~/Shape/KPCAS/Results/Cluster/clustering_iris_wine_vote.mat
load ~/Shape/KPCAS/Results/Cluster/clustering_liver.mat
load ~/Shape/KPCAS/Results/Cluster/clustering_ecoli_all_cluster.mat

for caseNum = [ 1:8 ]
  switch caseNum
    case 1
      kpca        = squeeze (blood (1,:,:));
      kpcas       = squeeze (blood (2,:,:));
      spectralCun = squeeze (blood (3,:,:));
      spectralCsm = squeeze (blood (4,:,:));
      spectralCjw = squeeze (blood (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterBlood.png'
    case 2
      kpca        = squeeze (ecoli (1,:,:));
      kpcas       = squeeze (ecoli (2,:,:));
      spectralCun = squeeze (ecoli (3,:,:));
      spectralCsm = squeeze (ecoli (4,:,:));
      spectralCjw = squeeze (ecoli (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterEcoli.png'
    case 3
      kpca        = squeeze (haberman (1,:,:));
      kpcas       = squeeze (haberman (2,:,:));
      spectralCun = squeeze (haberman (3,:,:));
      spectralCsm = squeeze (haberman (4,:,:));
      spectralCjw = squeeze (haberman (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterHaberman.png'
    case 4
      kpca        = squeeze (heart (1,:,:));
      kpcas       = squeeze (heart (2,:,:));
      spectralCun = squeeze (heart (3,:,:));
      spectralCsm = squeeze (heart (4,:,:));
      spectralCjw = squeeze (heart (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterHeart.png'
    case 5
      kpca        = squeeze (iris (1,:,:));
      kpcas       = squeeze (iris (2,:,:));
      spectralCun = squeeze (iris (3,:,:));
      spectralCsm = squeeze (iris (4,:,:));
      spectralCjw = squeeze (iris (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterIris.png'
    case 6
      kpca        = squeeze (liver (1,:,:));
      kpcas       = squeeze (liver (2,:,:));
      spectralCun = squeeze (liver (3,:,:));
      spectralCsm = squeeze (liver (4,:,:));
      spectralCjw = squeeze (liver (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterLiver.png'
    case 7
      kpca        = squeeze (vote (1,:,:));
      kpcas       = squeeze (vote (2,:,:));
      spectralCun = squeeze (vote (3,:,:));
      spectralCsm = squeeze (vote (4,:,:));
      spectralCjw = squeeze (vote (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterVote.png'
    case 8
      kpca        = squeeze (wine (1,:,:));
      kpcas       = squeeze (wine (2,:,:));
      spectralCun = squeeze (wine (3,:,:));
      spectralCsm = squeeze (wine (4,:,:));
      spectralCjw = squeeze (wine (5,:,:));
      dimensionAll = [ 1 : size(kpca,1) ]
      filenamePic = 'clusterWine.png'
    otherwise
      error ('');
  end
  
% $$$   figure('Position',scrsz); set (gca,'FontSize', 50); hold on;
% $$$   %
% $$$   plot ( dimensionAll, median (kpcas, 2), 'b*-', ...
% $$$          dimensionAll, median (kpca , 2), 'ro-' ,...
% $$$          dimensionAll, median (spectralCsm, 2), 'g*-' ,...
% $$$          dimensionAll, median (spectralCun, 2), 'c*-' ,...
% $$$          dimensionAll, median (spectralCjw, 2), 'k*-' ,...
% $$$          'LineWidth', 2, 'MarkerSize', 10 );
% $$$   legend ('kPCAs', 'kPCA', 'spectralCsm', 'spectralCun', 'spectralCjw', 'Location', 'SouthEast');
% $$$   %
% $$$   bp = boxplot (kpcas' , 'positions', dimensionAll, 'symbol', '', 'notch', 'off', 'whisker', 1.0);
% $$$   set (bp (:,1:end), 'color', 'b', 'linewidth', 1);
% $$$   delete (findobj (gca, 'Type', 'text'));
% $$$   %
% $$$   bp = boxplot (kpca' , 'positions', dimensionAll, 'symbol', '', 'notch', 'off', 'whisker', 1.0);
% $$$   set (bp (:,1:end), 'color', 'r', 'linewidth', 1);
% $$$   delete (findobj (gca, 'Type', 'text'));
% $$$   %
% $$$   bp = boxplot (spectralCsm' , 'positions', dimensionAll, 'symbol', '', 'notch', 'off', 'whisker', 1.0);
% $$$   set (bp (:,1:end), 'color', 'g', 'linewidth', 1);
% $$$   delete (findobj (gca, 'Type', 'text'));
% $$$   %
% $$$   bp = boxplot (spectralCun' , 'positions', dimensionAll, 'symbol', '', 'notch', 'off', 'whisker', 1.0);
% $$$   set (bp (:,1:end), 'color', 'c', 'linewidth', 1);
% $$$   delete (findobj (gca, 'Type', 'text'));
% $$$   %
% $$$   bp = boxplot (spectralCjw' , 'positions', dimensionAll, 'symbol', '', 'notch', 'off', 'whisker', 1.0, 'Labels', dimensionAll);
% $$$   set (bp (:,1:end), 'color', 'k', 'linewidth', 1);
% $$$   delete (findobj (gca, 'Type', 'text'));
% $$$   %
% $$$   axis tight; grid on;
% $$$   xlabel ('Dimension of Linear Subspace Chosen');
% $$$   ylabel ('Clustering Rate');
% $$$   pause
% $$$   export_fig (filenamePic, '-a2', '-png');
% $$$   close
  
  figure('Position',scrsz); set (gca,'FontSize', 50); hold on;
  %
  plot ( dimensionAll-0.1, 1-median (spectralCsm, 2), 'k.-' ,...
         dimensionAll+0.1, 1-median (kpca , 2), 'r.-' ,...
         dimensionAll, 1-median (kpcas, 2), 'b.-', ...
         'LineWidth', 5, 'MarkerSize', 25 );
  if caseNum == 8
      legend ('Spectral Clustering', 'kPCA', 'kPGA', 'Location', 'East');
  end
  %
  bp = boxplot (1-spectralCsm' , 'positions', dimensionAll-0.1, 'symbol', '', 'notch', 'off', 'whisker', 1.5);
  set (bp (:,1:end), 'color', 'k', 'linewidth', 1);
  delete (findobj (gca, 'Type', 'text'));
  %
  bp = boxplot (1-kpca' , 'positions', dimensionAll+0.1, 'symbol', '', 'notch', 'off', 'whisker', 1.5);
  set (bp (:,1:end), 'color', 'r', 'linewidth', 1);
  delete (findobj (gca, 'Type', 'text'));
  %
  dimensionAllShow = num2str (dimensionAll');
  dimensionAllShow (2:4:end,:) = ' '; dimensionAllShow (3:4:end,:) = ' '; dimensionAllShow (4:4:end,:) = ' ';
  bp = boxplot (1-kpcas' , 'positions', dimensionAll, 'symbol', '', 'notch', 'off', 'whisker', 1.5, 'Labels', dimensionAllShow);
  set (bp (:,1:end), 'color', 'b', 'linewidth', 1);
  set (findobj (gca, 'Type', 'text'), 'FontSize', 50);
  %
  axis tight; grid on; a = axis; a(3) = a(3) - 0.05; axis (a);
  xlabel ('Dimension of Subspace Chosen');
  ylabel ('Clustering Error Rate');
  % pause
  export_fig (filenamePic, '-a2', '-png');
  close
end
