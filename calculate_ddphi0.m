function f=calculate_ddphi0(phi0,dphi0)
global kN k1 k2 eps   last_theta last_dtheta

last_thetaN=last_theta(end); last_dthetaN=last_dtheta(end);

%calculate reference of head angle - ref_thetaN
global ref_thetaN

uphi0=(1/eps)*(last_dthetaN+kN*(last_thetaN-ref_thetaN))-k1*phi0-k2*dphi0;

ddphi0=uphi0;
f=ddphi0;