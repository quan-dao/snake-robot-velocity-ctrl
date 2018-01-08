function f=createNumerical_matrixQtheta(N,theta)
Stheta=createNumerical_matrixStheta(N,theta);
Ctheta=createNumerical_matrixCtheta(N,theta);
global ct cn
tempfR_11=ct*Ctheta^2+cn*Stheta^2; tempfR_12=(ct-cn)*Stheta*Ctheta;
tempfR_22=ct*Stheta^2+cn*Ctheta^2;
f=-[tempfR_11 tempfR_12;tempfR_12 tempfR_22];
end