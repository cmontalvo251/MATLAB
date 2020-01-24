%%%Reset
clear
clc
close all

%%%Actuator Dynamics
A = tf([3],[1,3])
wn = 20.0
G = tf([wn^2],[1,2,wn^2])*A
%G = tf([1],[1,2,1,0])
margin(G)
grid on
[Gm,Pm,Wcg,Wcp] = margin(G)
%%%The Margins are
disp(['Gain Margin = ',num2str(Gm)])
disp(['Phase Margin = ',num2str(Pm)])

%%%The gain margin tells us how much gain the system
%%%The system can handle. Since our gain margin is positive
%%%It means we need to LOWER the bode plot. This means we 
%%%Need to multiply our plot by a number less than 1.
%%%%In this case we can use our gain margin to determine
%%%What we can make K to stabilize the system
%%multiply by 99% to reduce it just 
%%%under the stability boundary
K = Gm*0.99; 
GCL = minreal(K*G/(1+K*G))

%%%As can be seen by this step response
figure()
step(GCL)
grid on

%%%%And this pzmap
figure()
pzmap(GCL)

%%%To see a more detailed view you can run rlocus
figure()
rlocus(G)
%%%Click on the locus where the poles cross the imaginary
%%%axis and you'll see that when K = Gm the system goes unstable

%%%%Notice that if K > Gm the system is unstable

%%%The negative phase means that are system is lagging
%%%Behind by 34 degrees. There is no way to simply increase
%%%phase. Lead lag filters are the best at adding phase
%%%to a system
%%%Using the equations from Brian Douglas we can 
%%%Tune a lead/lag filter
%https://www.youtube.com/watch?v=rH44ttR3G4Q&list=PLUMWjy5jgHK24TCFwngV5MeiruHxt1BQR&index=7
%%%We're just going to add the phase margin to the frequency at which the
%%%phase margin occurs
phi_max = Pm; 
wm = Wcp;
%sind(phi_max) = (a2-1)/(a2+1)
%a2*sind(phi_max) + sind(phi_max) = a2 - 1
%a2*(sind(phi_max) - 1) = -sind(phi_max) - 1
a2 = (-sind(phi_max) - 1)/(sind(phi_max) - 1)
tau = 1/(wm*sqrt(a2))
%%%Then build the compensator
C = tf([a2*tau,1],[tau,1])

%%%Then create a new open loop system
CG = C*G
%%%And compute the bode plot again
margin(CG)
grid on
[Gm,Pm,Wcg,Wcp] = margin(CG)
%%%The Margins are
disp(['Gain Margin = ',num2str(Gm)])
disp(['Phase Margin = ',num2str(Pm)])

%%%Now the system has a phase margin at 0 rad/s which is basically
%%%MATLAB saying that it can't find when the system crosses 0 dB
%%%The good news is that we now have a gain margin that is greater than 1
%%%Which means that we can make K bigger than 1
%%%under the stability boundary
K = Gm*0.99; 
GCL = minreal(K*CG/(1+K*CG))

%%%As can be seen by this step response
figure()
step(GCL)
grid on

%%%%And this pzmap
figure()
pzmap(GCL)

%%%To see a more detailed view you can run rlocus
figure()
rlocus(CG)
%%%Click on the locus where the poles cross the imaginary
%%%axis and you'll see that when K = Gm the system goes unstable

%%%%Notice that if K > Gm the system is unstable