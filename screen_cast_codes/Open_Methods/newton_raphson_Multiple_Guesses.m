function x0 = newton_raphson_Multiple_Guesses()
clear
clc

xi = [10 -0.5 -0.2 0.2 0.5 10];

alfa = 0.1;

%%%Need to iterate on each guess one at a time
for x0 = xi
	xinitial = x0;
	err = abs(f(x0));
	iter = 0;
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
	disp(['xinitial = ',num2str(xinitial),' x0 = ',num2str(x0),' ','err = ',num2str(err),' iters = ',num2str(iter)])
end

function out = f(in)

%out = in*(in-1)*(in+1); %%%x = 1 leads to y = 0
%out = in*(in^2-1)
out = in^3 - in;

function out = fprime(in)

out = 3*in^2-1;

function out = fdblprime(in)

out = 6*in;
