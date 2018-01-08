function f=calculate_khi4(N,m,theta)
E=createNotation_matrixE(N);
Qtheta=createNumerical_matrixQtheta(N,theta);

f=(1/(N*m))*E'*Qtheta*E;
end