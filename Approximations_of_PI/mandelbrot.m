function mypi = mandelbrot(N)


c = 0.25 + 1/N;
z = 0;

mypi = 0;

while z <= 2
   z = z^2 + c; 
   mypi = mypi + 1;
end