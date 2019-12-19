function Gas_Processing()
clear
clc
close all

format long g

%%%%%Plot Objective Function
x1 = 0:0.1:12;
x2 = 0:0.1:12;
[xg1,xg2] = meshgrid(x1,x2);
fg = -(150*xg1+175*xg2);
%mesh(xg1,xg2,fg)
hold on

%%%%Plot Constraints
x2C1 = (77-7*x1)/11;
fC1 = objfun([x1;x2C1]);
plot3(x1,x2C1,fC1,'r-')

x2C2 = (80-10*x1)/8;
fC2 = objfun([x1;x2C2]);
plot3(x1,x2C2,fC2,'b-')

x1C3 = 9*ones(1,length(x1));
fC3 = objfun([x1C3;x2]);
plot3(x1C3,x2,fC3,'g-')

x2C4 = 6*ones(1,length(x1));
fC4 = objfun([x1;x2C4]);
plot3(x1,x2C4,fC4,'m-')

%%%%Restrict Viewing Axis
xlim([0 12])
ylim([0 12])
view(0,90)

%%%solve problem using fmincon
%%%Initial Guess 
x0 = [1;1];
options = optimset('LargeScale','off');
[xf,fm] = fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options);
x1Gas = xf(1)
x2Gas = xf(2)
Cost = -fm
plot3(x1Gas,x2Gas,fm,'bs','MarkerSize',20)

xlabel('Regular Gas (Tonnes)')
ylabel('Premium Gas (Tonnes)')

legend('Volume Constraint','Time Constraint','Storage Constraint (Regular)','Storage Constraint (Premium)')

%%%Pareto Frontier
A = [0,6];
B = [1.5,6];
C = xf';
D = [8,0];

plot3(A(1),A(2),0,'b*','MarkerSize',20)
plot3(B(1),B(2),0,'b*','MarkerSize',20)
plot3(C(1),C(2),0,'b*','MarkerSize',20)
plot3(D(1),D(2),0,'b*','MarkerSize',20)

%%%%Feasible Design Space
F = [A;B;C;D;[0,0]];
patch(F(:,1),F(:,2),'g')

function f = objfun(x)
x1 = x(1,:);
x2 = x(2,:);
f = -(150*x1 + 175*x2);


function [cineq,ceq] = confun(x)
x1 = x(1);
x2 = x(2);
cineq = [7*x1+11*x2-77;
    10*x1+8*x2-80;
    x1-9;
    x2-6;
    -x1;
    -x2];
ceq = [];