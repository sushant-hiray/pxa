function [v] = kernel_optimization_find_v(G,KDataS,v0,prevMapping,Data)
    % KDataS is data on the sphere
    %v0 as initialized by kPCA
    % ensure that updates are prep to prevMappings
    
    KData = kernel_log_map(G,KDataS,v0);
    num_feat = size(KData,1);
    num_points = size(KData,2);
    currVD = zeros(size(v0));
    v = v0;
    currRes = kernel_residual_function(G,KData,currVD);
    currGrad = kernel_grad_function(G,KData,currVD);
    prevRes = 2*pi;
    currResOuter= currRes;
    prevResOuter = 2*pi;
    threshold = 1E-5;
    stepSize = 0.1;
    MAX_ITER =100;
    curr_iter =0;
    %fprintf('objective function values');
    %KData = Data in tangent feature space.
   while(abs(prevResOuter - currResOuter)/abs(prevResOuter) > threshold)
        run_atleast_once = true;
        currVD = zeros(size(v0));
        stepSize = 0.1;
        currRes = kernel_residual_function(G,KData,currVD);
        while(run_atleast_once ||abs(prevRes - currRes)/abs(prevRes) > threshold && curr_iter <MAX_ITER)
          currGrad = kernel_grad_function(G,KData,currVD);
          currVD = currVD - stepSize*currGrad;
          tempRes = kernel_residual_function(G,KData,currVD);
          if(tempRes < currRes)
              prevRes = currRes;
              currRes = tempRes;
              stepSize = stepSize*1.1;
          else
              currVD = currVD + stepSize*currGrad;
              stepSize = stepSize/2;
          end
          curr_iter = curr_iter+1;
          currRes;
          run_atleast_once = false;
        end
        currVD = currVD - ((currVD'*G*v0)/(v0'*G*v0))*v0;
        v = kernel_exp_map(G,currVD,v);
        KData = kernel_log_map(G,KDataS,v);
        prevResOuter = currResOuter;
        currResOuter =  kernel_residual_function(G,KData,zeros(size(currVD)));
        run_atleast_once = true;
        prevRes = 2*pi;
    end
    % update v0 o
    
   
    %fprintf('iterations : %d  & stepsize %f',curr_iter,stepSize);
end