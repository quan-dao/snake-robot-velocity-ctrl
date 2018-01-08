clear all
close all
clc
%----Global constants----%
global N m l J cn ct kN k1 k2 eps  vref k_lamda K_z ref_thetaN K_P K_D alpha gamma
N=8; %the number of links
m=1; l=0.07; J=0.0016; ct=0.1; cn=1; %Links' parameters
eps=0.5*10^-1; 
% delta=1.4 %head reference's parameters
kN=3; k1=1; k2=1; %Head angle Control 's parameters - eq 5.16
k_lamda=20; K_z=10; %eq 5.34's parameters

K_P=2.5; K_D=0.5;
%-----Set point----%
vref=5/100; ref_thetaN=-pi/4;

alpha=30*pi/180; gamma=72*pi/180;

t0=0; tfin=80; tsamp=0.1; num_seg_t=(tfin-t0)/tsamp;

init_config_vars=[zeros(18,1);3;0]; %initial condition of configuration vars
init_phi0=[0;0]; %initial condition of phi0
init_lamda=[0;0]; %initial condition of lamda

global last_theta last_dtheta last_p last_dp last_dphi0 last_phi0 u

%Notation matrix
D=createNotation_matrixD(N);

%initialize vector
ref_phi=zeros(N-1,1); dref_phi=zeros(N-1,1); ddref_phi=zeros(N-1,1); u=zeros(N-1,1);


for k=1:num_seg_t
    k
% time interval
    current_t=t0+k*tsamp;
    interval=[current_t-tsamp,current_t]; %[already known, haven't known] the output of the system
%last output
   last_theta=init_config_vars(1:2:15);
   last_dtheta=init_config_vars(2:2:16);
   last_p=init_config_vars(17:2:19);
   last_dp=init_config_vars(18:2:20);
    
   if size(last_dp)==[1 2]
            last_dp=last_dp';
   end
   if size(last_dtheta)==[1 N]
            last_dtheta=last_dtheta';
   end
   if size(last_theta)==[1 N]
            last_theta=last_theta';
   end
%Head angle control
    [t1 out1]=ode45('ode_phi0',interval,init_phi0);
    phi0(k)=out1(end,1); dphi0(k)=out1(end,2); 
    init_phi0=out1(end,:);
%Velocity control
    last_dphi0=dphi0(k); last_phi0=phi0(k);
    [t2 out2]=ode45('new_ode_lamda',interval,init_lamda);
    lamda(k)=out2(end,1); dlamda(k)=out2(end,2);
    init_lamda=out2(end,:);
%calculate input torque
    M_theta=calculate_matrixMtheta(last_theta);
    W_theta=calculate_matrixWtheta(last_theta);
    SCtheta=createNumerical_matrixSCtheta(N,last_theta);
    fR=calculate_fR(last_theta,last_dtheta,last_p,last_dp);
    b=[zeros(N-2,1);1];
    ddphi0=calculate_ddphi0(phi0(k),dphi0(k));
    ddlamda=new_calculate_ddlamda(lamda(k),dlamda(k));
    %VHC and its derivative
    for i=1:(N-1)
       ref_phi(i)=alpha*sin(lamda(k)+(i-1)*gamma);
       dref_phi(i)=alpha*cos(lamda(k)+(i-1)*gamma);
       ddref_phi(i)=alpha*cos(lamda(k)+(i-1)*gamma)-dlamda(k)^2*alpha*sin(lamda(k)+(i-1)*gamma);
    end
    invM=M_theta^-1;
 u=(D*invM*D')^-1*(D*invM*W_theta*last_dtheta.^2-l*D*invM*SCtheta'*fR+ddref_phi*dlamda(k)^2+dref_phi*ddlamda+b*ddphi0-K_P*(D*last_theta-ref_phi-b*phi0(k))-K_D*(D*last_dtheta-dref_phi*dlamda(k)-b*dphi0(k)));
%calculate output
    [t3 out3]=ode45('ode_snakeRob',interval,init_config_vars);
    %update initial condition for config vars
    init_config_vars=out3(end,:);
    %display output
    temp_theta=out3(end,1:2:15);
        theta1(k)=temp_theta(1); theta2(k)=temp_theta(2);theta3(k)=temp_theta(3); theta4(k)=temp_theta(4); theta5(k)=temp_theta(5); theta6(k)=temp_theta(6); theta7(k)=temp_theta(7); thetaN(k)=temp_theta(8);
    temp_p=out3(end,17:2:19);
        px(k)=temp_p(1); py(k)=temp_p(2);
    temp_dp=out3(end,18:2:20);    
        if size(temp_dp)==[1 2]
            temp_dp=temp_dp';
        end
        vt(k)=[cos(thetaN(k)),sin(thetaN(k))]*temp_dp;
      
end
time=linspace(t0,tfin,num_seg_t);
figure
subplot(3,1,1)
plot(time,phi0,time,dphi0)
legend('phi0','dphi0')
grid on
subplot(3,1,2)
plot(time,lamda,time,dlamda)
legend('lamda','dlamda')
grid on
subplot(3,1,3)
plot(px,py)
legend('CM position')
grid on
figure
plot(time,theta1,time,theta2,time,thetaN,time,ref_thetaN+zeros(num_seg_t,1),'.-');
legend('theta1','theta2','thetaN')
grid on
figure
plot(time,vt,time,vref+zeros(num_seg_t,1),'r-')
legend('vt','v ref')
grid on







