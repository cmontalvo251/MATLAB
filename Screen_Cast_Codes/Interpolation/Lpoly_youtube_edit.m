function fn = Lpoly_youtube_edit(x,xsamples,fsamples,N)
%%%x is input vector and N is order
%%%xsamples are the sample points
%%%fsamples is the function f(x) evaluated at xsamples

%%%initialize fn
fn = 0*x;

%%%%Error checking
if length(fsamples)-1<N
    disp('Need more fsamples');
    return
end

%%%%First loop
for idx = 0:N
    %%%Initialize Li
    Li = 0*x+1;
    %%%%Loop for Li
    for jdx = 0:N
        if jdx ~= idx
            xi = xsamples(idx+1);
            xj = xsamples(jdx+1);
            Lnext = (x-xj)/(xi-xj);
            Li = Li.*Lnext;
        end
    end
    %%%Summation step
    fn = fn + Li*fsamples(idx+1);
end