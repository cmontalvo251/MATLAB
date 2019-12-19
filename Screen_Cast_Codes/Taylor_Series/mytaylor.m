function out = mytaylor(x,x0,N)
%%%%Expands the function sin(x) using an Taylor series expansion Nth order
%%%%using expansion point x0


out = 0;

for idx = 0:N
    
    D = dervis(x0,idx);
    
    if idx == 0
        s = D;
    else
        s = D*((x-x0).^(idx))./factorial(idx);
    end
    
    out = out + s;
    
end
