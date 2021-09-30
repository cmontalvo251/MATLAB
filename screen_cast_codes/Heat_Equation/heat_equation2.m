clear

clc

close all

L = 80;

delx=0.1;

x=0:delx:L;

x=x';

number_of_pipe_sections = length(x);

N = number_of_pipe_sections;

u=100*sin(x*pi/80);

figure

plot(x,u);

xlabel('Length','FontSize', 16)

ylabel('Temperature','FontSize', 16)

figure

t(1)=0;

n=1;

delt=0.1;

c = 0.01;

udbl = 0*x;

while t<100

 for m=1:length(x)

 if m>length(x)-3

udbl(m) = (u(m)-2*u(m-1)+u(m-2))/(delx^2);

 else

udbl(m)= (u(m+2)-2*u(m+1)-u(m))/(delx^2);

 end

 end

% udblprime=udbl;

udot = c^2 * udbl;

u(:,n+1)=u(:,n)+udot*delt;

t(n+1)=t(n)+delt;

n=n+1;

end

mesh(u)
