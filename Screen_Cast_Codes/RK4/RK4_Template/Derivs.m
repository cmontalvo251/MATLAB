function xkdot = Derivs(tk,xk)

g = 9.81;
L = 4;

xkdot = [xk(2);-g/L*xk(1)];