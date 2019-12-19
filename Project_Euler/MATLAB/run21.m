%%Run 21 find all amicable pairs under 10,000

tic

n = 1:10000;
dn = 0.*n;
pairs = 0;
%%Populate dn
for ii = 1:10000
  if dn(ii) == 0
    [dn(ii) dummy] = divisors(ii);
  end
  %%2 possible scenarios
  %1. dn >  ii
  %2. dn < ii
  if dn(ii) > ii && dn(ii) < 10000
    %%then we want to check dn(dn(ii))
    dnii = dn(ii);
    [dn(dnii) dummy] = divisors(dnii);
    %%now if dn(dnii) = ii we have an amicable pair
    if dn(dnii) == ii
      pairs = pairs + ii + dnii;
    end
  else
    %%we don't want to do anything
  end
end


toc