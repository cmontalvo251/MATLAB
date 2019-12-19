clear
clc
close all

%%%Get parameters
parameters

%%%%Setup time vector
tfinal = 20;
dt = 0.01;
time = 0:dt:tfinal;

%%%Setup state vector
xstate = zeros(2+Num_rods*2,length(time));

%%%Setup initial conditions
%%% State = [theta,thetadot,phi0,phidot0,...phiN,phidotN];
theta = 0;
thetadot = 0;
x0 = [theta;thetadot];
phidot = 0;
for idx = 1:Num_rods
    xrod = [psi_vec(idx)+theta;phidot];
    x0 = [x0;xrod];
end
xstate(:,1) = x0;

%%%%Kick off RK4
for idx = 1:length(time)-1
    xi = xstate(:,idx);
    ti = time(idx);
    k1 = Derivatives(xi,ti);
    k2 = Derivatives(xi+k1*dt/2,ti+dt/2);
    k3 = Derivatives(xi+k2*dt/2,ti+dt/2);
    k4 = Derivatives(xi+k3*dt,ti+dt);
    k = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    xstate(:,idx+1) = xi + k*dt;
    [dxdt,xstate(:,idx+1)] = Collision_Check(xstate(:,idx+1),xstate(:,idx+1));
    disp(['Time = ',num2str(ti),' Tfinal = ',num2str(tfinal)])    
end

%%%%Plot Disk
theta = xstate(1,:);
thetadot = xstate(2,:);
plottool(1,'Theta',12,'Time (sec)','Theta and Thetadot');
%plot(time,theta,'b-')
plot(time,thetadot,'r-')

%%%Plot rods and compute KE,PE
[f1,h1] = plottool(1,'Energy',12);
KE = 0.25*M*r^2*thetadot.^2;
PE = 0*KE;
plot(h1,time,KE,'b-.')
for idx = 1:Num_rods
    s = 3+(idx-1)*2;
    phi_phidot = xstate(s:s+1,:);
    phi = phi_phidot(1,:);
    phidot = phi_phidot(2,:);
    %plottool(1,num2str(idx),12,'Phi and Phidot');
    %plot(time,phi_phidot)
    %%%Kinetic Energy 
    KErod = 0.5*m*r^2*thetadot.^2 + L*m*r*cos(theta-phi+psi_vec(idx)).*thetadot.*phidot+0.5*L^2*m*phidot.^2;
    KE = KE + KErod;
    %%%Potential Energy
    PErod = - m*g*(L*cos(phi) + r*cos(theta+psi_vec(idx))) + (L+r)*m*g; %%% the plus mg is for the offset to zero it out
    PE = PE + PErod;
    %%%Plot single rod
    plot(h1,time,KErod,'b--')
    plot(h1,time,PErod,'r--')
end

%%%Plot Kinetic Energy, Potential Energy and Total Energy
%%%For 1
%KE = (0.5*m+0.25*M)*r^2*thetadot.^2 + L*m*r*cos(theta-phi+psi1).*thetadot.*phidot+0.5*L^2*m*phidot.^2;
%PE = -m*g*(L*cos(phi) + r*cos(theta+psi1));
%%%For 2
%KE = (1.0*m+0.25*M)*r^2*thetadot.^2 + L*m*r*thetadot*(cos(theta-phi2+psi2)*phidot2+cos(theta-phi1+psi1).*phidot1)+0.5*L^2*m*phidot1.^2+0.5*L^2*m*phidot2;
%PE = -m*g*(L*cos(phi1) + L*cos(phi2) + r*cos(theta+psi1) + r*cos(theta+psi2));
Etot = KE+PE;
pKE = plot(h1,time,KE,'b-');
pPE = plot(h1,time,PE,'r-');
pE = plot(h1,time,Etot,'k-','LineWidth',2);
legend([pKE,pPE,pE],'KE','PE','Etot')

pause

%%%Make visualization
skip = 1;
plottool(1,'Video',12,'X','Y');
for idx = 1:skip:length(time)
    cla;
    axis([-(L+r) (L+r) -(L+r) (L+r)])
    %%%Unwrap state
    theta = xstate(1,idx);
    %%%Plot a line signifying xW
    plot([0 r*cos(theta)],[0 r*sin(theta)],'b-')
    %%%Plot a line to each rod
    TWI = [cos(theta) sin(theta);-sin(theta) cos(theta)];
    rcmB = [L;0];
    for jdx = 1:Num_rods
        rcW = [r*cos(psi_vec(jdx));r*sin(psi_vec(jdx))];
        rcW_I = TWI'*rcW;
        plot([0 rcW_I(1)],[0 rcW_I(2)],'g-','LineWidth',2)
        %%%Plot the rod itself
        phi = xstate(3+2*(jdx-1),idx);
        TIB = [cos(phi) sin(phi);-sin(phi) cos(phi)];
        rcm_I = TIB'*rcmB;
        rmI = rcW_I + rcm_I;
        plot([rcW_I(1) rmI(1)],[rcW_I(2) rmI(2)],'m-','LineWidth',3)
    end
    %%%Make a title
    title(num2str(time(idx)))
    %%%Rotate Axis
    view(90,90)
    %%%Plot the disk
    circ = 0:0.1:3*pi;
    xd = r*cos(circ);
    yd = r*sin(circ);
    plot(xd,yd,'k-')
    %%%Plot a triangle support
    plot([(L+r) 0],[(L) 0],'k-')
    plot([(L+r) 0],[-(L) 0],'k-')
    %%%Draw loop
    drawnow
end