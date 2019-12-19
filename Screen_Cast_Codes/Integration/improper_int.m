%%%%Integrate 1/x^2 from 1 to infinity
function I = improper_int()

B = 100000;

xi = 1;
dx = 0.0001;
I = 0;
%%%First Integral
while xi <= B

   %%The function evaluated at xi
   fxi = myfunc(xi);

   %%%Integrate
   I = I + fxi*dx;

   %%%Step my state
   xi = xi + dx;
end

%%%%Second Integral from 0 to 1/B (1/t^2)*f(1/t) dt where t = 1/x
dt = 0.000001;
ti = dt;
while ti <= 1/B
   %%%%Evaluate the function at ti
   fti = (1/ti^2)*myfunc(1/ti);
   
   I = I + fti*dt;
   
   %%%step my state
   ti = ti + dt;
end



function out = myfunc(in)
  out = (1/in^2);
