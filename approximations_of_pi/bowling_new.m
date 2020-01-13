function bowling_new(n)
  
x = 1/((16*100^n));
alfa = atan(2*sqrt(x)/(1-x))
alfa_approx = atan(1/(2*10^n))
alfa_approx_approx = 1/(2*10^n)
number_of_collisions = pi/(2*alfa)
cos(number_of_collisions*alfa)