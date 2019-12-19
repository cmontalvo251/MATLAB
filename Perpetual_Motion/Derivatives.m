function dxdt = Derivatives(xstate,time)

%%%Get parameters
parameters

%%%Unwrap Vector
theta = xstate(1);
thetadot = xstate(2);

%%%%NEED TO FIND A WAY TO INHIBIT ROD MOTION USING A FUNCTION OF PSI AND
%%%%PHI

%%%Create Inertia Matrix
IM = zeros(Num_rods+1,Num_rods+1);
for idx = 1:Num_rods+1
    for jdx = 1:Num_rods+1
        if idx == 1 && jdx == 1
            %%%IM(1,1)
            IM(idx,jdx) = 0.5*M*r^2+Num_rods*m*r^2;
        end
        if idx == jdx && idx ~= 1
            %%%IM(2,2) IM(3,3) IM(4,4) etc
            IM(idx,jdx) = m*L^2;
        end
        if jdx == 1 && idx ~= 1
           %%%1st column 
           phi = xstate(3+2*(idx-2));
           IM(idx,jdx) = L*m*r*cos(theta-phi+psi_vec(idx-1));
        end
        if idx == 1 && jdx ~= 1
            %%1st row
            phi = xstate(3+2*(jdx-2));
            IM(idx,jdx) = L*m*r*cos(theta-phi+psi_vec(jdx-1));
        end
    end
end

IM

pause
    
%%%%Generate Momentum Vector
P = zeros(Num_rods+1,1);
for idx = 1:Num_rods+1
    if idx == 1
        for jdx = 1:Num_rods
            phi = xstate(3+2*(jdx-1));
            phidot = xstate(4+2*(jdx-1));
            P(idx) = P(idx) + L*m*r*sin(theta-phi+psi_vec(jdx))*phidot^2;
        end
    else
        phi = xstate(3+2*(idx-2));
        P(idx) = P(idx) - L*m*r*sin(theta-phi+psi_vec(idx-1))*thetadot^2;
    end
end

%%%Generate Potential Vector
V = zeros(Num_rods+1,1);
for idx = 1:Num_rods+1
    if idx == 1
        for jdx = 1:Num_rods
            V(idx) = V(idx) - m*g*r*sin(theta+psi_vec(jdx));
        end
    else
        phi = xstate(3+2*(idx-2));
        V(idx) = V(idx) - m*g*L*sin(phi);
    end
end

%%%Compute ddot (thetadbldot,phidbldot)
ddot = inv(IM)*(-P+V);

%%%Generate dxdt vector
thetaddot = ddot(1)-0*thetadot;
phiddot_vec = ddot(2:end);
dxdt = zeros(2+2*Num_rods,1);
dxdt(1) = thetadot;
dxdt(2) = thetaddot;
for idx = 1:Num_rods
    phidot = xstate(4+2*(idx-1));
    phiddot = phiddot_vec(idx);
    dxdt(3+2*(idx-1)) = phidot;
    dxdt(4+2*(idx-1)) = phiddot;
end

%%%%Collision Check
dxdt = Collision_Check(dxdt,xstate);