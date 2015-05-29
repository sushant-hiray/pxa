function res = kernel_residual_vec(G,KData,v,r)
    Error = KData'*G*v;
    res = abs(acos(Error) - r)';
end