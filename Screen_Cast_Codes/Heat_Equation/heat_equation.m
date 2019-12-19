clear
clc
close all

L = 80;
delt=0.01;
delx=0.01;

t = 0:delt:100;
x=(0:delx:L)';
N = length(x);

c = 0.95/(0.092*8.92);
c = 0.01;

udblprime = 0*x;

u = 100*sin(x*pi/80);

plottool(1,'Name',18,'X (m)','Temperature (F)');
plot(x,u);

next = 10;
threshold = 0;

fout = fopen('Temperature.txt','wb');

for idx = 1:length(t)

  if next >= 0
    percent = (floor(100*t(idx)/t(end)));
    if percent >= threshold
      disp(['Simulation ',num2str(percent),'% Complete'])
      threshold = threshold + next;
      fprintf(fout,'%f ',t(idx));
      for outdx = 1:length(u)
	fprintf(fout,'%f ',u(outdx));
      end
      fprintf(fout,'\n');
    end
  end
  
  for m= 1:length(x)
    if m>length(x)-3
      udblprime(m) = (u(m)-2*u(m-1)+u(m-2))/(delx^2);
    else
      udblprime(m)= (u(m+2)-2*u(m+1)-u(m))/(delx^2);
    end
  end  

  udot = c^2 * udblprime;
  u = u+udot*delt;

end

fclose all;

data = dlmread('Temperature.txt');

t = data(:,1);
u = data(:,2:end);
if sum(u(:,end)) == 0
  u = u(:,1:end-1)
end
skip = 5;
u = u(:,1:skip:end);
[r,c] = size(u);
x = linspace(0,L,c);

plottool(1,'Name',18,'Time (sec)','X (m)','Temperature (F)');
[xx,tt] = meshgrid(x,t);
mesh(tt,xx,u)

