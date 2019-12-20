%%%%Let's do the second order spring mass damper
figure()
hold on
for kd = 0:0.1:3
    %kd = 2
    kd 
    kp = 0.8*((2-kd)*(kd+1)-1)
    D = [1 1 3 kd+1 kp+1]
    r = roots(D)
    plot(real(r),imag(r),'b*','MarkerSize',20)
    pause
end

return


%%%%Let's do the chapter 6 example
figure()
hold on
for kp = 0:0.1:9
    kp
    D = [1 3 2 kp];
    r = roots(D)
    plot(real(r),imag(r),'b*','MarkerSize',20)
   pause
end