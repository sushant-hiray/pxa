function [mode] = runTests(Data,v,r)
    alpha = 0.5;
    [vGreat,rGreat] = findSphere(Data,1);
    [vSmall,rSmall] = findSphere(Data,0);
    resGreat = residualVec(Data,vGreat,rGreat);
    resSmall = residualVec(Data,vSmall,rSmall);
    p = likelihood_ratio_test(resGreat,resSmall);
    
    if(p>alpha)
        mode = 1;
    else
        % run the parametric bootstrap test to ensure if the likelihood test has not detected an overfitting.
        mode = parametric_bootstrap_test(Data,v,r);
        if(mode == 1)
            mode =2;
        end
    end 
end