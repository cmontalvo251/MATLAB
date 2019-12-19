function primeN(n)

div = n-1;

while div >= 2;
    rem = mod(n,div);
    if rem == 0;
        disp('Not Prime');
        break;
    else
        div = div-1;
    end    
end
if div == 1;
    disp('Prime');
end
