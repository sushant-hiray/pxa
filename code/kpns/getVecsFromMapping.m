function Vecs = getVecsFromMapping(Mapping)
   Vecs =[];
    if(size(Mapping,2) >0)
        Vecs = zeros(size(Mapping(1).v,1),size(Mapping,2));
   end
   for i =1 :size(Mapping,2)
        Vecs(:,i) = Mapping(i).v;
   end
   
end