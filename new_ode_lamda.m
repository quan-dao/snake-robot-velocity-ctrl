function f=new_ode_lamda(t,inp)
lamda=inp(1);
dlamda=inp(2);
global N m l alpha gamma last_theta last_dtheta last_dp vref k_lamda K_z
global last_phi0 last_dphi0
%calculate khi6
    %calculate dref_phi
    dref_phi=zeros(N-1,1);
    for i=1:(N-1)
       dref_phi(i)=alpha*cos(lamda+(i-1)*gamma); %just partial derivative
    end
    %generate Constraint Manifold
    last_thetaN=last_theta(end); last_dthetaN=last_dtheta(end);
    ctm=generate_constraintManifold(last_thetaN,last_dthetaN,lamda,dlamda,last_phi0,last_dphi0);
    ctm_theta=ctm(:,1); 
    %Notation matrix
    E=createNotation_matrixE(N);
    Qtheta=createNumerical_matrixQtheta(N,ctm_theta);
    SCtheta=createNumerical_matrixSCtheta(N,ctm_theta);
    H=createNotation_matrixH(N);
 khi6=(l/(N*m))*E'*Qtheta*SCtheta*H*dref_phi;
%calculate f2
    %u_thetaN & v_thetaN
    u_thetaN=[cos(last_thetaN);sin(last_thetaN)];
    v_thetaN=[-sin(last_thetaN);cos(last_thetaN)];
    %forward velocity error
    vt=transpose(u_thetaN)*last_dp;
    er_vt=vt-vref;
    %normal velocity
    vn=transpose(v_thetaN)*last_dp;
    %khi i-th
    khi4=calculate_khi4(N,m,ctm_theta);
    khi5=calculate_khi5(N,m,l,ctm_theta);
    khi7=calculate_khi7(N,m,l,ctm_theta);
    
f2=u_thetaN'*(khi4*u_thetaN*(er_vt+vref)+khi4*v_thetaN*vn+khi5*last_dthetaN)+last_dthetaN*vn+u_thetaN'*khi7*last_dphi0;
%error var z
z=dlamda+k_lamda*er_vt;
%u_lamda

u_lamda=-k_lamda*(f2+u_thetaN'*khi6*dlamda)-K_z*z-er_vt*u_thetaN'*khi6-vn*v_thetaN'*khi6;

ddlamda=u_lamda;

f=[dlamda;ddlamda];
