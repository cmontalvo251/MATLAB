clear
clc
close all

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


%###Zeros poles and gains
%# X = k / (s + c)
tau = 26;
c = 1/tau;
FVT = 306;
k = FVT*c;
N = [k];
D = [1,c];
G = tf(N,D)
tout = linspace(0,140,1000);
yout = step(G,tout);
hold on
plot(tout,yout+74,'r-','LineWidth',4)
legend('Experimental Data','Simulated Data')
xlabel('Time (sec)')
ylabel('Temperature (deg)')
grid on