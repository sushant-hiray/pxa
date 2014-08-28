
clear all
close all
rng (0);

dim = 4

% try this a 100 times
for tryNum = 1 : 10000
  
  '--------------------------------------------------'
  
  % Given unit vector 'v'
  % Goal is to rotate 'v' to [ 0 ... 0 1 ]
  v = 1e-2 + rand (dim, 1, 'single');
  flagZeroMask = rand (dim,1) > 0.7;
  if sum (flagZeroMask) == dim
    flagZeroMask (1) = 0;
  end
  v (flagZeroMask) = 0;
  v = v / norm (v);
  v
  
  % Permute the vector to have the non-zero term as the first element
  flagNonZero = find (abs (v) > 1e-2, 1);
  vPermuted = v;
  if flagNonZero > 1
    tmp = vPermuted (flagNonZero);
    vPermuted (flagNonZero) = vPermuted (1);
    vPermuted (1) = tmp;
  end
  
  % Create a linearly-independent basis in dim-dimensional space
  X = eye (dim, 'single');
  X (:,1) = vPermuted;
  X
  assert (cond (X) > 1e-2, 'columns are linearly dependent')
  
  % Gram-Schmidt orthogonalization
  % Start from the vector 'v'. This ensures that 'v' is in the final set of vectors.
  Y = zeros (size (X), 'single');
  for d = 1  : dim
    Y (:, d) = X (:, d);
    % remove components along all previously-selected basis vectors
    for e = 1 : d-1
      Y (:, d) = Y (:, d) - (X (:, d)' * Y (:, e)) * Y(:,e);
    end;
    % make residual unit norm
    Y(:,d) = Y(:,d) / (1e-8 + norm (Y(:,d)));
    % this is the new basis vector
  end
  
  % flip the first vector ('v') with the last vector
  % just permuting basis columns
  Y (:,1) = Y (:,dim);
  Y (:,dim) = vPermuted;
  Y
  assert (norm (Y * Y' - eye (dim, 'single')) < 1e-4)
  assert (norm (Y' * Y - eye (dim, 'single')) < 1e-4)
  
  % the required rotation matrix is Y'
  R = Y';
  % R * vPermuted
  
  % permute the first column and flagNonZero-th column in R
  tmp = R (:,1);
  R (:, 1) = R (:, flagNonZero);
  R (:, flagNonZero) = tmp;
  R
  % ensure that the determinant of R = +1
  if det (R) < 0
    R (1,:) = - R (1,:);
  end
  vRotated = R * v
  assert (abs (det (R) - 1) < 1e-4);
  assert (norm (R * R' - eye (dim, 'single')) < 1e-4)
  assert (norm (R' * R - eye (dim, 'single')) < 1e-4)
  assert (mean (abs (vRotated (1:end-1))) < 1e-4);
  assert (      abs (vRotated (end) - 1)  < 1e-4);
  
  % compare with alternate solution
  a = v;
  b = zeros (dim, 1, 'single');  b (end) = 1;
  c = b - (a' * b) * a;  c = c / (1e-8 + norm (c));
  A = a * c' - c * a';
  theta = acos (a' * b);
  Rother = expm (theta * A)'
  assert (abs (det (Rother) - 1) < 1e-4);
  assert (norm (Rother * Rother' - eye (dim, 'single')) < 1e-4)
  assert (norm (Rother' * Rother - eye (dim, 'single')) < 1e-4)
  vRotatedOther = Rother * v
  assert (mean (abs (vRotatedOther (1:end-1))) < 1e-4);
  assert (      abs (vRotatedOther (end) - 1)  < 1e-4);
  
  % pause
end
