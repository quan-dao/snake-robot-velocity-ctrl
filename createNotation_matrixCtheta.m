function f=createNotation_matrixCtheta(N,theta)
temp=sym('temp',[N,N]);
for i=1:N
   for j=1:N
      if j==i
          temp(i,j)=cos(theta(i));
      else
          temp(i,j)=0;
      end
   end
end
f=temp;