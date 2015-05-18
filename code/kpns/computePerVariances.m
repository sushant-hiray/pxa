function R_total= computePerVariances(data,k,name)

% k = max no of dimensions in data
% Run KPNS Gaussian
% Run KPCA Gaussian
% Run KPNS NPoly -3
% Run KPCA NPoly -3
% Run KPNS NPoly -5
% Run KPCA NPoly -5
% Run PCA

options.KernelType='Gaussian';
options.degree=5;
PGS =1;
[Mapping,BkGm,R_kernel_Gaussian,Res] = kernel_pnsMain(data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(data,options);
R_kpca_gauss = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=3;
[Mapping,BkGm,R_kernel_np3,Res_np3] = kernel_pnsMain(data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(data,options);
R_kpca_np3 = 100*eig_val/sum(eig_val);

options.KernelType='NPolynomial';
options.degree=5;
[Mapping,BkGm,R_kernel_np5,Res_np5] = kernel_pnsMain(data,1,PGS,options);
[ eigvec, eig_val ] = kpca_main(data,options);
R_kpca_np5 = 100*eig_val/sum(eig_val);

options.KernelType='Linear';
[ eigvec, eig_val ] = kpca_main(data,options);
R_linear = 100*eig_val/sum(eig_val);

max_dim = max([size(R_kernel_Gaussian,1),size(R_kernel_np3,1),size(R_kernel_np5,1),size(R_kpca_gauss,1),size(R_kpca_np3,1),size(R_kpca_np5,1),size(R_linear,1)]);
R_kernel_Gaussian = padarray(R_kernel_Gaussian,[(max_dim -size(R_kernel_Gaussian,1)) 0],0,'post');
R_kernel_np3 = padarray(R_kernel_np3,[(max_dim -size(R_kernel_np3,1)) 0],0,'post');
R_kernel_np5 = padarray(R_kernel_np5,[(max_dim -size(R_kernel_np5,1)) 0],0,'post');
R_kpca_gauss = padarray(R_kpca_gauss,[(max_dim -size(R_kpca_gauss,1)) 0],0,'post');
R_kpca_np3 = padarray(R_kpca_np3,[(max_dim -size(R_kpca_np3,1)) 0],0,'post');
R_kpca_np5 = padarray(R_kpca_np5,[(max_dim -size(R_kpca_np5,1)) 0],0,'post');
R_linear = padarray(R_linear,[(max_dim -size(R_linear,1)) 0],0,'post');

R_total = [R_kernel_Gaussian R_kernel_np3 R_kernel_np5 R_kpca_gauss R_kpca_np3 R_kpca_np5 R_linear];
%{
nums = 1:1:max_dim;
f=figure()
for(i=1:size(R_total,2))
    plot(nums',R_total(:,i),'-','Color',rand(3,1));
    hold on;
end
legend('KPNS-Gaussian','KPNS-NP3', 'KPNS-NP5','KPCA-Gaussian','KPCA-NP3','KPCA-NP5','PCA')  
saveas(f,strcat(name,'_var'),'png')
Cumm_R = cumsum(R_total,1);
f=figure();
for(i=1:size(R_total,2))
    plot(nums',Cumm_R(:,i),'-','Color',rand(3,1));
    hold on;
end
saveas(f,strcat(name,'_cumm'),'png')
legend('KPNS-Gaussian','KPNS-NP3', 'KPNS-NP5','KPCA-Gaussian','KPCA-NP3','KPCA-NP5','PCA')  
R_total = Cuum_R;
%}
end