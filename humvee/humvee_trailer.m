purge

global mark1D
mark1D = 1;

MYPLOT = 1;
SAVEFILE = 0;
SKIP = 100;
INTERPPATCHON = 1;

if ~INTERPPATCHON
    USEPATCH = 1;
else
    USEPATCH = 0;
end

make_mountain

if SAVEFILE
    MYPLOT = 1;
end

if MYPLOT 
    plottool(1,'Mountain',14,'X (m)','AGL (m)');
end

%%%Simulate a Car Driving across the platform
%%%Initial Conditions
parameters
xcar = Lcar/2+Lt;
ycar = 0;
timestep = 0.001;
if INTERPPATCHON
    zcar = interppatch(centroidsxy,xp,yp,zp,xcar,0)-rcg_Tire(3,1);
else
    zcar = interp1(xmountain,zmountain,xcar)-rcg_Tire(3,1);
end
phi = 0;
if INTERPPATCHON
    theta = get_theta_patch(centroidsxy,xp,yp,zp,xcar,0);
else
    theta = get_theta(xmountain,zmountain,xcar);
end

psi = 0;

%%%Initial Forward Speed
u = xdot_car/1.5;
v = 0;
w = 0;
%Initial Angular Velocity
p = 0;
q = 0;
r = 0;

State = [xcar;ycar;zcar;phi;theta;psi;u;v;w;p;q;r;phi;theta;psi;p;q;r];
time = 0:timestep:20;
StateOUT = zeros(length(State),length(time));
%while State(1) < xmountain(end)-Lcar/2
skip = 1;
next = 100;
framenumber = 1;
maxdigits = 5;
for idx = 1:length(time)
    if MYPLOT && skip == idx
        cla
        plot3(xmountain,0*xmountain,zmountain)
        axis equal
        CubeDraw(Lcar,1,1,State(1),State(2),State(3),State(4),State(5),State(6),[1 0 0])
        rHumvee = State(1:3);
        TIB = R123(State(4:6));
        rH = rHumvee + TIB*rcg_Hitch;
        %%%And Location of Trailer
        TIB = R123(State(13:15));
        rtrailer = rH + TIB*rH_trailer;
        xT = rtrailer(1);
        yT = rtrailer(2);
        zT = rtrailer(3);
        CubeDraw(Lt,1,1,xT,State(2),zT,State(13),State(14),State(15),[0 1 0])
        xlim([State(1)-10 State(1)+10])
        reverse('z')
        view(39,12)
        drawnow
        %pause
        if SAVEFILE
            save_frame(['Frames/',getfilename(framenumber,maxdigits)])
            framenumber = framenumber + 1;
        end
    end
    if skip == idx
        skip = idx + next;
        disp(['Simulation ',num2str(round(100*idx/length(time))),' Complete'])
    end
    StateOUT(:,idx) = State;
    if INTERPPATCHON
        k1 = Derivatives_patch(State,centroidsxy,xp,yp,zp);
        k2 = Derivatives_patch(State+k1*timestep/2,centroidsxy,xp,yp,zp);
        k3 = Derivatives_patch(State+k2*timestep/2,centroidsxy,xp,yp,zp);
        k4 = Derivatives_patch(State+k3*timestep,centroidsxy,xp,yp,zp);
    else
        k1 = Derivatives(State,xmountain,zmountain);
        k2 = Derivatives(State+k1*timestep/2,xmountain,zmountain);
        k3 = Derivatives(State+k2*timestep/2,xmountain,zmountain);
        k4 = Derivatives(State+k3*timestep,xmountain,zmountain);
    end
    State = State + (1/6)*(k1 + 2*k2 + 2*k3 + k4)*timestep;
    
end

xcar = StateOUT(1,:);
ycar = StateOUT(2,:);
zcar = StateOUT(3,:);
phi_car = StateOUT(4,:);
theta_car = StateOUT(5,:);
psi_car = StateOUT(6,:);
ucar = StateOUT(7,:);
vcar = StateOUT(8,:);
wcar = StateOUT(9,:);
pcar = StateOUT(10,:);
qcar = StateOUT(11,:);
rcar = StateOUT(12,:);

%%%Compute Location of Hitch and Velocity of Trailer
phi_trailer = StateOUT(13,:);
theta_trailer = StateOUT(14,:);
psi_trailer = StateOUT(15,:);
p_trailer = StateOUT(16,:);
q_trailer = StateOUT(17,:);
r_trailer = StateOUT(18,:);
xtrailer = 0*xcar;
ytrailer = 0*ycar;
ztrailer = 0*zcar;
u_trailer = 0*xtrailer;
v_trailer = 0*ytrailer;
w_trailer = 0*ztrailer;
for idx = 1:length(xcar)
    rHumvee = [xcar(idx);ycar(idx);zcar(idx)];
    TIB = R123(phi_car(idx),theta_car(idx),psi_car(idx));
    rH = rHumvee + TIB*rcg_Hitch;
    %%%And Location of Trailer
    TIB = R123(phi_trailer(idx),theta_trailer(idx),psi_trailer(idx));
    rtrailer = rH + TIB*rH_trailer;
    xtrailer(idx) = rtrailer(1);
    ytrailer(idx) = rtrailer(2);
    ztrailer(idx) = rtrailer(3);
    %%%Velocity of Trailer
    pqr = [pcar(idx);qcar(idx);rcar(idx)];
    pqr_trailer = [p_trailer(idx);q_trailer(idx);r_trailer(idx)];
    Kuvw = skew(pqr);
    Kuvw_trailer = skew(pqr_trailer);
    vTrailer = [ucar(idx);vcar(idx);wcar(idx)] + Kuvw*rcg_Hitch + Kuvw_trailer*rH_trailer;
    u_trailer(idx) = vTrailer(1);
    v_trailer(idx) = vTrailer(2);
    w_trailer(idx) = vTrailer(3);
end
%theta_mountain = get_theta(xmountain,zmountain,xcar);
%theta_trailer_mountain = get_theta(xmountain,zmountain,xtrailer);

plottool(1,'XvsY',12,'X (m)','Y (m)');
plot(xcar,ycar,'b-','LineWidth',2)

plottool(1,'Theta',12,'Time (sec)','\theta (deg)');
plot(time,theta_car*180/pi,'b-','LineWidth',2)
%plot(time,theta_mountain*180/pi,'b--','LineWidth',2)
plot(time,theta_trailer*180/pi,'r-','LineWidth',2)
%plot(time,theta_trailer_mountain*180/pi,'r--','LineWidth',2)
%legend('\theta Humvee','\theta Mountain','\theta Trailer','\theta Trailer Mountain')
legend('\theta Humvee','\theta Trailer')

plottool(1,'Psi',12,'Time (sec)','\psi (deg)');
plot(time,psi_car*180/pi,'b-','LineWidth',2)
plot(time,psi_trailer*180/pi,'r-','LineWidth',2)
legend('\psi Humvee','\psi Trailer')

%plottool(1,'Theta',12,'Time (sec)','\theta Error (deg)');
%plot(time,(theta_car-theta_mountain)*180/pi,'b-','LineWidth',2)
%plot(time,(theta_trailer-theta_trailer_mountain)*180/pi,'r-','LineWidth',2)
%legend('Humvee','Trailer')

plottool(1,'Phi Channel',14,'Time (sec)','\phi (deg)');
%phi_car = 10*get_phi(time,1);
%phi_trailer = 10*get_phi(time,1);
plot(time,phi_car*180/pi,'b-','LineWidth',2)
plot(time,phi_trailer*180/pi,'r-','LineWidth',2)
legend('\phi Humvee','\phi Trailer')

outputvec = [time;xcar;ycar;zcar;phi_car;theta_car;psi_car;xtrailer;ytrailer;ztrailer;phi_trailer;theta_trailer;psi_trailer]';

dlmwrite('Humvee_Trailer.txt',outputvec(1:SKIP:end,:),'delimiter',' ','precision','%.6f')

humveestate = [time;xcar;ycar;zcar;phi_car;theta_car;psi_car;ucar;vcar;wcar;pcar;qcar;rcar]';

dlmwrite('Humvee.txt',humveestate(1:SKIP:end,:),'delimiter',' ','precision','%.6f')

trailerstate = [time;xtrailer;ytrailer;ztrailer;phi_trailer;theta_trailer;psi_trailer;u_trailer;v_trailer;w_trailer;p_trailer;q_trailer;r_trailer]';

dlmwrite('Trailer.txt',trailerstate(1:SKIP:end,:),'delimiter',' ','precision','%.6f')