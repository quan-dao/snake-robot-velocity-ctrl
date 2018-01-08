function f=calculate_khi7(N,m,l,theta)
E=createNotation_matrixE(N);
Qtheta=createNumerical_matrixQtheta(N,theta);
SCtheta=createNumerical_matrixSCtheta(N,theta);
H=createNotation_matrixH(N);
b=[zeros(N-2,1);1];
f=(l/(N*m))*E'*Qtheta*SCtheta*H*b;
end