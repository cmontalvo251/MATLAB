function x0 = newton_raphson();
clear
clc

x0 = 10;

iter = 0;

alfa = 0.1;

err = abs(f(x0));

while err > 1e-5
    
    iter = iter + 1;

    %%%Finds the zero
    x1 = x0 - alfa*f(x0)/fprime(x0);
    %%%Finds the minimum
    %x1 = x0 - alfa*fprime(x0)/fdblprime(x0);
    
    x0 = x1;

	err = abs(f(x0));

	%disp([num2str(x0),' ',num2str(err)])

	%pause

end

disp(['x0 = ',num2str(x0),' ','err = ',num2str(err),' iters = ',num2str(iter)])

function out = f(in)

%out = in*(in-1)*(in+1); %%%x = 1 leads to y = 0
%out = in*(in^2-1)
out = in^3 - in;

function out = fprime(in)

out = 3*in^2-1;

function out = fdblprime(in)

out = 6*in;
