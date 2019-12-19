function fxn = Lpoly(x,xsamples,fsamples,N)

%%%Initialize your sum
fxn = 0*x;

%%%Error checking
if N > length(fsamples)-1
    disp('Sorry you need more sample points')
    return
end

for idx = 0:N
    %%%Initialize Li
    Li = 0*x+1;
    for jdx = 0:N
        if idx ~= jdx
            xi = xsamples(idx+1);
            xj = xsamples(jdx+1);
            Lnext = (x-xj)/(xi-xj);
            Li = Li.*Lnext;
        end
    end
    fxn = fxn + Li*fsamples(idx+1);
end