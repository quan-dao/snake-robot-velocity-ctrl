function f=calculate_khi5(N,m,l,theta)
E=createNotation_matrixE(N);
Qtheta=createNumerical_matrixQtheta(N,theta);
SCtheta=createNumerical_matrixSCtheta(N,theta);
e=1+zeros(N,1);

f=(l/(N*m))*E'*Qtheta*SCtheta*e;
end