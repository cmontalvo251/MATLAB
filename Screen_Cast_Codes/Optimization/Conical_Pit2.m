function Conical_Pit()
close all
%%%%COMPUTE EVERYTHING
r = 0.1:0.1:10;
Cost = f(r);
rmin = fminbnd(@f,0.1,8)
hmin = height(rmin)
r45 = fzero(@theta0,2)


%%PLOT FIRST FIGURE
figure()
plot(r,Cost)
hold on
plot(r45,f(r45),'g*','MarkerSize',20)
plot(rmin,f(rmin),'r*','MarkerSize',20)

%%%PLOT SECOND FIGURE
figure()
plot(r,theta(r)*180/pi)
hold on
plot(r45,theta(r45)*180/pi,'g*','MarkerSize',20)
plot(rmin,theta(rmin)*180/pi,'r*','MarkerSize',20)

function t = theta(r)
t = atan(height(r)./r);

function t0 = theta0(r)
t0 = atan(height(r)./r) - 45*pi/180;

function Cost = f(r)
h = height(r);
SA = pi*r.*(sqrt(r.^2+h.^2));
A = pi*r.^2;
Cost = 5000 + SA*50 + 25*A;

function h = height(r)
h = 150./(pi*r.^2);