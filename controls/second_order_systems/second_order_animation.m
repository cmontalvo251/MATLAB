clear
clc
close all

m = 12;
k = 2;
c = 3;
kd = 10;
figure()
for kp = 0:0.1:10
   G = tf([(k+kp)/m],[1 (c+kd)/m (k+kp)/m])
   s1 = (-(c+kd)/m + sqrt((c+kd)^2/m^2 - 4*(k+kp)/m))/2;
   s2 = (-(c+kd)/m - sqrt((c+kd)^2/m^2 - 4*(k+kp)/m))/2;
   disp(s1)
   disp(s2)
   %plot(real(s1),imag(s1),'bx','MarkerSize',15)
   %hold on
   %plot(real(s2),imag(s2),'bx','MarkerSize',15)
   step(G)
   hold on
   pause
end