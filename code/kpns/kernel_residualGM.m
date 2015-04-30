function res = kernel_residualGM(G,KData,v)
    TData = kernel_log_map(G,KData,v);
    res = sqrt(max (diag(TData'*G*TData), 1E-10))';
end