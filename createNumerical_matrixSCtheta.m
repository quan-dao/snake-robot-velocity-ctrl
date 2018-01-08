function f=createNumerical_matrixSCtheta(N,theta)
A=createNotation_matrixA(N);
D=createNotation_matrixD(N);
K=A'*inv(D*D')*D;
Stheta=createNumerical_matrixStheta(N,theta);
Ctheta=createNumerical_matrixCtheta(N,theta);
f=[K'*Stheta;-K'*Ctheta];
