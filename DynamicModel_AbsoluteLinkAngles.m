clear all
close all
clc
%-----Constant-----%
syms m l J real% links parameters
N=8; % the number of links
%-----Config vars-----%
%Actuated
syms phi1 phi2 phi3 phi4 phi5 phi6 phi7 real% joint angles
qa=[phi1;phi2;phi3;phi4;phi5;phi6;phi7];
%Unactuated
syms thetaN px py real % head angle, CM of robot 's coordiantes
qu=[thetaN;px;py];
%total config vars
q=[qa;qu];
%velocity
syms dphi1 dphi2 dphi3 dphi4 dphi5 dphi6 dphi7 real
dqa=[dphi1;dphi2;dphi3;dphi4;dphi5;dphi6;dphi7];
syms dthetaN dpx dpy real
dqu=[dthetaN;dpx;dpy];
dq=[dqa;dqu];
% absolute angle of i-th link
syms theta1 theta2 theta3 theta4 theta5 theta6 theta7 theta8 dtheta1 dtheta2 dtheta3 dtheta4 dtheta5 dtheta6 dtheta7 dtheta8 real
theta=[theta1;theta2;theta3;theta4;theta5;theta6;theta7;theta8];
dtheta=[dtheta1;dtheta2;dtheta3;dtheta4;dtheta5;dtheta6;dtheta7;dtheta8];
%-----Notaion Matrix-----%
A=createNotation_matrixA(N);
D=createNotation_matrixD(N);
matN=A'*inv(D*D')*D;
V=A'*inv(D*D')*A;
e=1+zeros(N,1);
Stheta=createNotation_matrixStheta(N,theta);
Ctheta=createNotation_matrixCtheta(N,theta);
R=createNotation_matrixR(N);
%-----KINEMATIC-----%
vec_ctheta=sym('vec_ctheta',[N,1]); vec_stheta=sym('vec_stheta',[N,1]);
for i=1:N
    vec_ctheta(i)=cos(theta(i));
    vec_stheta(i)=sin(theta(i));
end
% global CM position of each link
x=-l*matN'*vec_ctheta+e*px;    
y=-l*matN'*vec_stheta+e*py;
% global velocity of CM of each link
dx=l*matN'*Stheta*dtheta+e*dpx;
dy=-l*matN'*Ctheta*dtheta+e*dpy;
%-----Anisotropic Friction Model-----%
syms ct cn %friction coefficient
tempfR_11=ct*Ctheta^2+cn*Stheta^2; tempfR_12=(ct-cn)*Stheta*Ctheta;
tempfR_22=ct*Stheta^2+cn*Ctheta^2;
fR=-[tempfR_11 tempfR_12;tempfR_12 tempfR_22]*[dx;dy];
%-----Equations of Motion-----%
temp_M_theta=Stheta*V*Stheta+Ctheta*V*Ctheta;
M_theta=J*eye(N)+m*l^2*temp_M_theta;
W_theta=m*l^2*(Stheta*V*Ctheta-Ctheta*V*Stheta);

