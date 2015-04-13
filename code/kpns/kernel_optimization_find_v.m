function [v] = kernel_optimization_find_v(G,KData,v0,prevMapping)
    % KData in tangent feature space
    %v0 as initialized by kPCA
    % ensure that updates are prep to prevMappings
    num_feat = size(KData,1);
    num_points = size(KData,2);
    currVD = v0;
    currRes = kernel_residual_function(G,KData,currVD);
    currGrad = kernel_grad_function(G,KData,currVD);
    prevRes = 2*pi;
    threshold = 1E-5;
    stepSize = 1E-3;
    
    while(abs(prevRes - currRes)/abs(prevRes) > threshold)
      currGrad = kernel_grad_function(G,KData,currVD);
      currVD = currVD - stepSize*currGrad;
      tempRes = kernel_residual_function(G,KData,currVD);
      if(tempRes < currRes)
          prevRes = currRes;
          currRes = tempRes;
          stepSize = stepSize*1.1;
      else
          currVD = currVD + 2*stepSize*currGrad;
          stepSize = stepSize/2;
      end
    end
    % update v0 
    v = kernel_exp_map(G,currVD,v0);

end