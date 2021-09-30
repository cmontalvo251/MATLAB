function D = dervis(x0,N)
D = 0;
while N >= 0
    if N == 0
        D = sin(x0);
        return
    elseif N==1
        D = cos(x0);
        return
    elseif N==2
        D = -sin(x0);
        return
    elseif N==3
        D = -cos(x0);
        return
    end
    if N > 3
        N = N-4;
    end
end
