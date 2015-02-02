function [pval] = likelihood_ratio_test(resGREAT,resSMALL)
    n = size(resGREAT,2);
    chi2 = max(n*log(sum(resGREAT.^2)/sum(resSMALL.^2)),0);
    pval = 1-chi2cdf(chi2,1) % p-value of the likelihood test
end