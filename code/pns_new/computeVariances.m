function [Var] = computeVariances(Data,Mapping)
   m = size(Mapping,2);
   pData = Data;
   gm = Mapping(end).v;
   Var = [0];
   for i =1:m-1
       currentMap = Mapping(i);
       tData = projectOnSubSpace(pData,currentMap);     
       apparentGM = backProject(gm,Mapping(i:end-1));
       var = computeLevelVar(tData,apparentGM);
       pData = projectData(pData,currentMap);
       Var = Var/sin(currentMap.r);
       Var = [Var var]
   end
end