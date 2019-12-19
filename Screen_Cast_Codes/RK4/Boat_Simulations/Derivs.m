function xkdot = Derivs(tk,xk)
global thrust rudder

x = xk(1);
y = xk(2);
psi = xk(3);
u = xk(4);
r = xk(5);

%%%%Define our drag
Cd = 0.4;
Cn = 3;

%thrust = 0;
%rudder = 0;

if abs(rudder) > 0
    rudder = rudder - sign(rudder)*0.01;
end

xdot = cos(psi)*u;
ydot = sin(psi)*u;
psidot = r;
udot = -Cd*u + thrust;
rdot = -Cn*r + rudder;


xkdot = [xdot;ydot;psidot;udot;rdot];