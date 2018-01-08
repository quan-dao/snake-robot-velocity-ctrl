function f=calculate_ddlamda(lamda,dlamda)
global N m l alpha gamma last_theta last_dtheta last_dp vref k_lamda K_z
%calculate khi6
    %calculate dref_phi
    dref_phi=zeros(N-1,1);
    for i=1:(N-1)
        k=i;
       dref_phi(i)=dlamda*alpha*cos(lamda+(k-1)*gamma); 
    end
    %Notation matrix
    E=createNotation_matrixE(N);
    Qtheta=createNumerical_matrixQtheta(N,last_theta);
    SCtheta=createNumerical_matrixSCtheta(N,last_theta);
    H=createNotation_matrixH(N);
 khi6=(l/(N*m))*E'*Qtheta*SCtheta*H*dref_phi;
 %calculate f2
    %u_thetaN & v_thetaN
    last_thetaN=last_theta(end);
    u_thetaN=[cos(last_thetaN);sin(last_thetaN)];
    v_thetaN=[-sin(last_thetaN);cos(last_thetaN)];
    %forward velocity error
    vt=transpose(u_thetaN)*last_dp;
    er_vt=vt-vref;
    %normal velocity
    vn=transpose(v_thetaN)*last_dp;
    %khi i-th
    khi4=calculate_khi4(N,m,last_theta);
    khi5=calculate_khi5(N,m,l,last_theta);
    khi7=calculate_khi7(N,m,l,last_theta);
    
   global last_dphi0
   last_dthetaN=last_dtheta(end);

f2=u_thetaN'*(khi4*u_thetaN*(er_vt+vref)+khi4*v_thetaN*vn+khi5*last_dthetaN)+last_dthetaN*vn+u_thetaN'*khi7*last_dphi0;
%error var z
    z=dlamda+k_lamda*er_vt;
%u_lamda
    u_lamda=-k_lamda*(f2+u_thetaN'*khi6*dlamda)-K_z*z-er_vt*u_thetaN'*khi6-vn*v_thetaN'*khi6;

ddlamda=u_lamda;
f=ddlamda;
end