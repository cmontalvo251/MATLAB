function RI = romberg_integration(Norder,BaseN)
%%%I_1,4 - 4 order equivalent of the integration of my function
%%%I_1,order


RI = zeros(Norder,Norder);

%%%First step is to compute the first column of RI
for idx = 1:Norder
   RI(idx,1) = mytrapezoid(idx*BaseN);
end

%%%Fill out the rest of the columns
for col = 2:Norder
    k = col-1; %%second column
    for row = 1:(Norder-col+1)
        RI(row,col) = ((4^k)*RI(row+1,col-1)-RI(row,col-1))/(4^k-1);
    end
end


function I = mytrapezoid(N)
B = 1;
A = -1;
dx = (B-A)/N;
I = 0;
for x = A:dx:(B-dx)
    I = I + 0.5*(f(x)+f(x+dx))*dx;
end

function y = f(x)

y = 2*sqrt(1-x.^2);

