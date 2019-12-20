clear
clc
close all

%%%%Parameters of system
k1 = 1;
k2 = 1;
c1 = 1;
m1 = 1;
m2 = 1;

%%%State space from EOMS and FBDs
A = [0 0 1 0;0 0 0 1;-(k1+k2)/m1 k2/m1 -c1/m1 0;k2/m2 -k2/m2 0 0]
B = [0;0;0;1/m2]

%%%%Eigenvalues Stable?
eig(A)

%%%Make a variable - may need to use computer lab
syms s

%%%Transfer function equation. This is in your book
G = inv(s*eye(4)-A)*B

%%%%Roots of the denominator should be the same as the
%%%%eigenvalues
D = [1 1 3 1 1];
roots(D)

%%%%I only need G = X1/F
X1 = tf([1],D)

%%%Simulate open loop
step(X1)

%%%Closed Loop System - let's do something fancy
STABLE = 0;
kp = -10;
kd = -10;
while ~STABLE
    kp = kp + 0.1
    if kp > 100
        kp = 0.1;
        kd = kd + 0.1
        if kd > 100
            disp('Parameters Exhausted')
            STABLE = 1;
        end
    end
    D_CL = [1 1 3 kd+1 kp+1];
    r = roots(D_CL);
    if all(real(r) < 0)
        disp('Stabilization Found')
        STABLE = 1;
    end
end
kp 
kd
roots(D_CL)
X1_CLOSED = tf([kp kd],D_CL);
impulse(X1_CLOSED)