function f=createNumerical_matrixStheta(N,theta)
temp=zeros(N,N);
for i=1:N
   for j=1:N
      if j==i
          temp(i,j)=sin(theta(i));
      else
          temp(i,j)=0;
      end
   end
end
f=temp;