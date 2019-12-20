function heat_up_iron()

 time_data = [
     0 
     5
10
15
20
25
30
35
40
45
50
55
60
65
70
75
80
85
90
95
100
105
110
115
120
125
130];

Temp_data = [ 74
126
174
205
244
285
320
350
380
410
430
420
400
380
375
366
360
390
380
370
365
361
382
380
375
371
365];

figure()
plot(time_data,Temp_data,'b*')
xlim([0 75])

[tout,zout]=ode45(@Derivatives,[0 75],[74;0]);

hold on
plot(tout,zout(:,1),'r-')

K = 0.00375;
C = 0.03;
Tss = 365;
I = K*Tss;
r1 = (-C/2) + sqrt(C^2-4*K)/2;
r2 = (-C/2) - sqrt(C^2-4*K)/2;
Amat = [1 1;r1 r2];
b = [74-I/K;0];
A1A2 = inv(Amat)*b;
A1 = A1A2(1);
A2 = A1A2(2);
Tanalytical = A1*exp(r1*tout) + A2*exp(r2*tout) + I/K;

plot(tout,Tanalytical,'g-')

%%%%Transfer function solution
A = I/K;
B = -A;
w = sqrt(K-C^2/4);
D = -A*C;
alfa = ((D+74*C)-(B+74)*C/2)/w;
Ttransfer = A + (B+74)*exp(-C/2*tout).*cos(w*tout) + alfa*exp(-C/2*tout).*sin(w*tout);

plot(tout,Ttransfer,'k-')

function dzdt = Derivatives(t,z)

T = z(1);
Tdot = z(2);

K = 0.00375;
C = 0.03;
Tss = 365;
I = K*Tss;
dzdt = [Tdot;I-C*Tdot-K*T];