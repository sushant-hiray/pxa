function [FracR] = getFracR(PathToMatFile, Dim)
    
    load(PathToMatFile);
    if(size(R_kpns_gauss,1) < Dim)
        R_kpns_gauss = padarray(R_kpns_gauss,Dim-size(R_kpns_gauss,1),'post');
    end
    if(size(R_kpns_gauss,1) < Dim)
        R_kpca_gauss = padarray(R_kpca_gauss,Dim-size(R_kpca_gauss,1),'post');
    end
    if(size(R_kpns_gauss,1) < Dim)
        R_kpns_np5 = padarray(R_kpns_np5,Dim-size(R_kpns_np5,1),'post');
    end
    if(size(R_kpns_gauss,1) < Dim)
        R_kpca_np5 = padarray(R_kpca_np5,Dim-size(R_kpca_np5,1),'post');
    end
    if(size(R_kpns_gauss,1) < Dim)
        R_linear = padarray(R_linear,Dim-size(R_linear,1),'post');
    end
    FracR = [R_kpns_gauss(1:Dim) R_kpca_gauss(1:Dim) R_kpns_np5(1:Dim) R_kpca_np5(1:Dim) R_linear(1:Dim)];
    FracR = cumsum(FracR,1);
end