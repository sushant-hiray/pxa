function KDataN = normalizeKernelData(G,KData)
    num_points = size(KData,2);
    KNorm = (diag(KData'*G*KData))';
    KNormRep = KNorm(ones(num_points,1),:);
    KDataN = KData./KNormRep;
end