function f=createNotation_matrixD(N)
temp=zeros(N-1,N);
for i=1:N-1
   for j=1:N
      if j==i
          temp(i,j)=1;
      elseif j==(i+1)
          temp(i,j)=-1;
      end
   end
end
f=temp;