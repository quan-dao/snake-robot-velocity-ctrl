function f=related_refthetaN(py,dpy,delta)

refthetaN=-atan(py/delta);
drefthetaN=-dpy*delta/(delta^2+py^2);
% Low pass filter
omega_n=pi/2; %natural frequency
xi_f=1; %damping coefficient
temp=[0 1;-omega_n^2 -2*xi_f*omega_n]*[refthetaN;drefthetaN]+[0;omega_n^2]*refthetaN;

ddrefthetaN=temp(2);
f=[refthetaN;drefthetaN;ddrefthetaN];