function constrained_opt()


x0 = [1;1]; %%%%Initial Condition or Initial Guess

%%%%@objfun is the function handle
options = optimset('LargeScale','off');
[x,fmincost] = fmincon(@objfun,x0,[],[],[],[],[],[],@confun,options)



function out = objfun(x)
x1 = x(1);
x2 = x(2);
out = -(150*x1 + 175*x2);

function [cineq,ceq] = confun(x)
x1 = x(1);
x2 = x(2);
cineq = [  %%%%Inequality constraints must be less than or equal to zero
    x1-9;
    x2-6;
    7*x1+11*x2-77;
    -x1;
    -x2;10*x1+8*x2-80];
ceq = [];   %%%Equality constraints must be equal to zero