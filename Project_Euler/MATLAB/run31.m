%%Find all possibilities of 2 pounds using french coins
clear all
%%2 coin combinations
for ii = 2:1:200
  strii = num2str(ii);
  eval(['p',strii,'2=length(',strii,':-2:1)+(1-mod(',strii,',2));'])
  %pause
end

%%5 coin combinations
for ii = 5:5:200
  strii = num2str(ii);
  eval(['p',strii,'5=1;'])
  for jj = 5:5:ii
    strjj = num2str(jj);
    eval(['p',strii,'5=p',strii,'5+p',strjj,'2;'])
    %pause
  end
end

%%10 coin combinations
for ii = 10:10:200
  strii = num2str(ii);
  eval(['p',strii,'10=1;'])
  for jj = 10:10:ii
    strjj = num2str(jj);
    eval(['p',strii,'10=p',strii,'10+p',strjj,'5;'])
    %pause
  end
end
%%20 coin combinations
for ii = 20:10:200
  strii = num2str(ii);
  if ~mod(ii,20)
    eval(['p',strii,'20=1;'])
  else
    eval(['p',strii,'20=0;'])
  end
  for jj = ii:-20:10
    strjj = num2str(jj);
    eval(['p',strii,'20=p',strii,'20+p',strjj,'10;'])
    %pause
  end
end
%%50 coin combinations
for ii = 50:50:200
  strii = num2str(ii);
  eval(['p',strii,'50=1;'])
  for jj = 50:50:ii
    strjj = num2str(jj);
    eval(['p',strii,'50=p',strii,'50+p',strjj,'20;'])
    %pause
  end
end
%%100 coin combos
p200100 = 1 + p20050 + p10050;

answer = p200100 + 1