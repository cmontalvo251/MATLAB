%%%%CLOSED LOOP
clear
clc
close all

M = 30/2.2;
m = 185/2.2;
l = 1.5;
g = 9.81;

%kp = 2000;
%kd = 1200;
%kd = 1000;
kp = 10000;

figure()
ax_rl = gca;
hold on
figure()
ax_tf = gca;
hold on
pause
for kd = 0:100:10000
    kd
    D = [(M+m)*l kd kp-(M+m)*g];
    r = roots(D)
    G_CL = tf([kp kd],D)
    plot(ax_rl,real(r),imag(r),'b*','MarkerSize',20)
    %impulse(ax_tf,G_CL)
    pause
end
