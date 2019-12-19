%Problem 9
%%Find a*b*c such that a+b+c = 1000 and a^2 + b^2 = c^2

tic

alpha = 1000;
for b = 1:1000
  c = (2*alpha*b-2*b^2-alpha^2)/(2*b-2*alpha);
  if c > 0 && round(c) == c && isreal(c)
    a = sqrt(c^2 - b^2);
    if a > 0 && round(a) == a && isreal(a)
      answer = a*b*c
      toc
      pause
    end
  end
end
