function f=createNotation_matrixH(N)
temp=zeros(N,N-1);
for i=1:N
   for j=1:(N-1)
      if j>=i
          temp(i,j)=1;
      end
   end
end
f=temp;
end