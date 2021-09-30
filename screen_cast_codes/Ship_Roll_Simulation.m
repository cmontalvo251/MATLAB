function Ship_Roll_Simulation()
  
clc
close all

%% Transfer function 
%G = 22.5 / (s+4) (s^2+0.9*s+9)

%% tf() or zpk()
roots_of_numerator = [];
roots_of_polynomial = roots([1,0.9,9]);
roots_of_denominator = [-4;roots_of_polynomial];
gain = 22.5;

%%%Describes the roll dynamics of a ship
G = zpk(roots_of_numerator,roots_of_denominator,gain);

%%%Assume the ship gets hit with a wave (finite)
[roll_out,tout] = impulse(G);
plot(tout,roll_out)
ylabel('Roll Angle(deg)')

%%%Convert it to State Space and use ode45
[A,B,C,D] = tf2ss(G);

[tout_45,xout] = ode45(@Derivs,tout,[0,0,0]');
%roll_out = C*xout (1x3) (128x3)
%roll_out = C*xout' (1x3) (3x128) --> (1x128)
roll_out_45 = C*xout';

hold on
plot(tout_45,roll_out_45,'r-')



%%%Animate it
figure()
for idx = 1:length(tout)
  cla;
  CubeDraw(10,5,3,0,0,0,roll_out_45(idx)*pi/180,0,0,[1 0.5 0]);
  axis([-3 3 -5 5])
  view(45,45)
  pause(0.05)
end

end

function dxdt = Derivs(t,x)
  A =[

    0.00000    0.00000   -3.60000;
   -1.00000    0.00000    1.26000;
    0.00000  -10.00000   -4.90000];

B =[

  -2.25000;
   0.00000;
   0.00000];

C =   [0   0  -1];

D = 0;

%%%u is the control input
%% A rogue wave of input energy 10. 
%% hits the ship for 0.1 seconds.
if t < 0.1
  u = 100;
else
  u = 0;
end

dxdt = A*x + B*u;
  
end


