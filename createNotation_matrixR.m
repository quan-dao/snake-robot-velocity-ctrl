function f=createNotation_matrixR(N)
temp=zeros(N,N);
for i=1:N
   for j=1:N
      if j>=i
         temp(i,j)=1; 
      end
   end
end
f=temp;