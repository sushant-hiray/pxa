function p = parametric_bootstrap_test(Data,v,r,alpha)
   mu = sum(Data,2);
   
   mu = mu/sqrt(mu'*mu);
   d = size(Data,1);
   rbar = norm(mu)/size(Data,2);
   kappa = (rbar.*(d+1) - rbar.^3)/(1-rbar.^2);
   B=100;
   samples = size(Data,2);
   
   Z =getParametric(Data,v,r);
   count = 0.0;
   for i=1:B
       BData = randvonMisesFisherm(size(Data,1), samples, kappa, mu);     
       zi = getParametric(BData,v,r);
       if(Z > zi)
           count = count+1;
       end
   end
   if(count/B < alpha)
        p =0;
   else
       p =1;
   end
end

function [p] = getParametric(Data,v,r)
    n = sum(Data,2);
    res = residualVec(Data,v,r);
    mean = sum(res)/n;
    vari = res-mean;
    vari = sum(vari.^2);
    p = mean/(vari/n-1)^0.5;
end