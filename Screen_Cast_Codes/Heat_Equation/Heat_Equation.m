clear
clc
close all


%A = [2.04 -1 0 0;-1 2.04 -1 0;0 -1 2.04 -1;0 0 -1 2.04];
%B = [40.8 0.8 0.8 200.8]';

T0 = 20;
TL = 800;

%T = [T0;inv(A)*B;TL]

delx = 8/12;

L = 2;

x = 0:delx:L;

Tguess = 0*x;

Tguess(1) = T0;
Tguess(end) = TL;

%Tguess = [T0 0 0 0 0 TL];

Ta = 20;
hprime = 5;

for iter = 1:100
  for idx = 2:length(Tguess)-1
    Tguess(idx) = (Tguess(idx-1) + hprime*delx^2*Ta + Tguess(idx+1))/(2+hprime*delx^2);
  end
end
disp(Tguess')

%A*exp(sqrt(hprime*0)) + B*exp(-sqrt(hprime*0)) = 40-Ta

AA = [exp(sqrt(hprime)*0) exp(-sqrt(hprime)*0); exp(sqrt(hprime)*L) exp(-sqrt(hprime)*L)];
BB = [T0-Ta;TL-Ta];
AABB = inv(AA)*BB;
A = AABB(1);
B = AABB(2);
T = A*exp(sqrt(hprime)*x) + B*exp(-sqrt(hprime)*x) + Ta;

fig = figure();
set(axes,'FontSize',14)
set(fig,'color','white')
plot(x,Tguess,'m*','MarkerSize',10)
grid on
hold on
plot(x,T,'b-','LineWidth',2)
legend('Numerical Solution','Analytical Solution')
xlabel('X (ft)')
ylabel('Temperature')

