function [dxdt,xstate] = Collision_Check(dxdt,xstate)

parameters

%%%Check for collisions
for jdx = 1:Num_rods
    %%%What you want to do is a dot product between rcW_I
    theta = xstate(1);
    TWI = [cos(theta) sin(theta);-sin(theta) cos(theta)];
    rcW = [r*cos(psi_vec(jdx));r*sin(psi_vec(jdx))];
    rcW_I = TWI'*rcW;
    %%% and rcm_I
    phi = xstate(3+2*(jdx-1));
    TIB = [cos(phi) sin(phi);-sin(phi) cos(phi)];
    rcmB = [L;0];
    rcm_I = TIB'*rcmB;
    %%%Dot product dot(rcW_I,rcm_I) = mag(rcW_I)*mag(rcm_I)*cos(delang)
    delangle = acos((rcW_I'*rcm_I)/(L*r));
    max_angle = 0.4;
    if delangle > max_angle
        %%%Set phidot = 0 and phidbldot = 0 since we are going to
        %%%artificially change phi
        dxdt(3+2*(jdx-1)) = 0;
        dxdt(4+2*(jdx-1)) = 0;
        %%%Ok I need to actually derive this by hand I think        
        %%%You need to solve - Mathematica!
        %pi/4 + 2 n pi - theta + phi - psi_vec(jdx) == 0 (solve for n) 
        n = (psi_vec(jdx)-phi+theta-max_angle)/(2*pi);
        %n = sign(n)*ceil(abs(n));
        %%%solve for phi now
        phidesired = psi_vec(jdx)+theta-max_angle-2*n*pi;
        %%%Check delangle again
        phi = phidesired;
        TIB = [cos(phi) sin(phi);-sin(phi) cos(phi)];
        rcmB = [L;0];
        rcm_I = TIB'*rcmB;
        %%%Dot product dot(rcW_I,rcm_I) = mag(rcW_I)*mag(rcm_I)*cos(delang)
        this_is_zero = acos((rcW_I'*rcm_I)/(L*r))-max_angle;
        xstate(3+2*(jdx-1)) = phidesired;
        %%%Also set phidot to zero
        xstate(4+2*(jdx-1)) = 0;
    end
end
%if theta < pi/2
    xstate(1) = 0;
    xstate(2) = 0;
%end
