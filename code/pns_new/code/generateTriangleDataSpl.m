function [Data] = generateTriangleDataSpl(N,noise)
   X = abs(randn(1,N))+ 1
   Rest1= -1*ones(1,N);
   Rest2= 1*ones(1,N);
   Data = [X;Rest1;Rest2];
   if(noise==1)
       Data = Data + 0.4*randn(size(Data));
   end
   Data = normc(Data);
end