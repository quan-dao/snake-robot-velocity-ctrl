function f=generate_constraintManifold(thetaN,dthetaN,lamda,dlamda,phi0,dphi0)
global N alpha gamma

e=1+zeros(N,1);
H=createNotation_matrixH(N);
b=[zeros(N-2,1);1];

ref_phi=zeros(N-1,1);dref_phi=zeros(N-1,1);
for i=1:(N-1)
   ref_phi(i)=alpha*sin(lamda+(i-1)*gamma);
   dref_phi(i)=alpha*cos(lamda+(i-1)*gamma);
end

ctrM_theta=e*thetaN+H*ref_phi+H*b*phi0;
ctrM_dtheta=e*dthetaN+H*dref_phi*dlamda+H*b*dphi0;

f=[ctrM_theta ctrM_dtheta];