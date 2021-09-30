function nonlinear_lifting_line()

clc
close all

panels = [0 1 2];

uvw_cg = [20;0;0];

%%%Initial Guess
inflow = zeros(1,length(panels))
uvw_panels = zeros(3,length(panels));
V_panels = zeros(1,length(panels));
inflow = zeros(1,length(panels));

iter = 0;
itermax = 100;
while iter < itermax

    %%%Velocity of panels
    for ii = 1:length(panels)
        uvw_panels(:,ii) = uvw_cg;
        uvw_panels(3,ii) = uvw_panels(3,ii) + inflow(ii);
        V_panels(ii) = norm(uvw_panels(:,ii));
    end

    %%%Angle of attack of panels
    alfa_panels = atan2(uvw_panels(3,:),uvw_panels(1,:));

    %%%Lift Coefficient of panels
    CL0 = 0.1;
    CLalfa = 2*pi;

    CL_panels = CL0 + CLalfa*alfa_panels;

    c = 0.3215;

    %%%%Circulation of panels
    gamma_panels = CL_panels.*c.*V_panels/2;

    %%%Compute Inflow on each panel
    inflownew = 0*inflow;
    for ii = 1:length(panels)
        for jj = 1:length(panels)
            wI = biot_savart(panels,gamma_panels,ii,jj);
            inflownew(ii) = inflownew(ii) - wI;
        end
    end
    inflow = inflow*0.9 + inflownew*0.1

    iter = iter + 1

    %pause(0.5)

end

function out = biot_savart(panels,gamma_panels,ii,jj)

panel1 = panels(ii);
panel2 = panels(jj);

gamma2 = gamma_panels(jj);

%%%Compute Point A and B of panel2
del_panel = panels(2)-panels(1);
rA = [panel2 - del_panel/2;0];
rB = [panel2 + del_panel/2;0];

%%%Compute location of point C
rC = [panel1;0.1];

%%%Compute theta1
rAB = rB-rA;
rAC = rC-rA;
rBC = rC-rB;

%%%||rAB|| ||rAC|| cos(theta1) = rAB'rAC
theta1 = acos((rAB'*rAC)/(norm(rAB)*norm(rAC)));
theta2 = acos((rAB'*rBC)/(norm(rAB)*norm(rBC)));

rp = abs(rAC(2));

out = gamma2/(4*pi*rp) * (cos(theta1) - cos(theta2));



