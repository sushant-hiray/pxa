[k n] = size(passed_data); % data on (k-1)-sphere in Real^k
[uu ll]=svd(passed_data,'econ');
maxd = find(diag(ll) < -1,1);
if isempty(maxd) || k > n
    maxd = min(k,n)+1;
end
nullspdim = k - maxd + 1; % dimension of subspace that contains no data

d = k - 1; % intrinsic dimension of the sphere
disp(['Message from PNSmain.m; dataset is on ' num2str(d) '-sphere.']);

dm = maxd - 2; % intrinsic dimension of the smallest nested sphere that
% contains variation. I.e. this is the dimension to which
% can be trivially reduced.

resmat = zeros(dm,n); % d dimensional residual matrix
% there will be dm-1 subspheres
orthaxis = cell(dm-1,1);
dist = zeros(dm-1,1);
pvalues = zeros(dm-1,2);
if nullspdim > 0
    disp([' .. found null space of dimension ' num2str(nullspdim)...
        ',to be trivially reduced.']);
    disp([' .. then narrow down to ' num2str(dm) '-sphere']);
    % (HDLSS case) fit nested great spheres for dimension reduction
    % where no residual is present.
    currentSphere = uu(:,1:(dm+1))'*passed_data ;
else
    disp([' .. Check that the following holds: ' num2str(d) ' = ' ...
        num2str(dm)]);
    currentSphere = passed_data;
end


subplot(1,2,1)
plot_rat_skull(passed_data,0);
axis equal tight;
hold on;

PGS =1;
[Mapping, BkGm,Res,NewBPData,AllRes] = pnsMain(currentSphere,1,PGS);

subplot(1,2,2)
plot_rat_skull(BkGm,0);
axis equal tight;
hold on;
plot_rat_skull_same(NewBPData,0);