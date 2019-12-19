function alfa = GetEnvelope(filename,prodasflag)
%This will take a file and potentially convert it to english units
%%then it will use the cyclic variables (v,w,q,r,Fy,Fz,M, and N) to
%%fit an exponential curve to the data and then average out this
%curve and spit back alfa such that y = Aexp(-alfa*t)

%%clear home
close all
clc

%%Import file in question
if prodasflag
  data = convertPRODAS(filename);
else
  data = dlmread(filename);
end
%%Get v,w,q,r,Fy,Fz,M,and N from data set
cyclicdata = data(:,[9,10,12,13,15,16,18,19]);
time = data(:,1);

%%let's generate some example data
% A = 10;
% alfaactual = 0.2;
% time = 0:0.01:10;
% freq = 10;
% yactual = A.*exp(-alfaactual.*time).*sin(freq.*time);
% ydata = yactual;

%%Algorithm to compute alfa involves using a newton-rhapson
%technique
alfa = 0;
for idx = 1:8
  %%Move through all cyclic values and determine alfa for each
  %cyclic state variable
  ydata = cyclicdata(:,idx);
  %%plot data just to make sure fits are right
  figure('Name',num2str(idx))
  plot(time,ydata)
  hold on
  %%Plot absolute value to help peak finding
  ydata = abs(ydata);
  plot(time,ydata,'r-')
  %%Get peak value(using 10% of data set take maximum value)
  l = length(time);
  numpts = floor(l*0.1);
  Aest = max(ydata(1:numpts));
  loc = find(ydata==Aest);
  tmax = time(loc);
  plot(time,Aest)
  %%Move through dataset and look for peaks
  tpeaks = tmax;
  Apeaks = Aest;
  for ii = (loc+1):length(time)-1
    prevVal = ydata(ii-1);
    postVal = ydata(ii+1);
    Val = ydata(ii);
    if prevVal < Val && postVal < Val
      Apeaks = [Apeaks Val];
      tpeaks = [tpeaks time(ii)];
    end
  end
  %%plot peaks
  plot(tpeaks,Apeaks,'m*')
  %%Now use linear regression to get value of alfa
  X = log(Apeaks./Aest)';
  H = [-(tpeaks-tmax)]';
  alfai = inv(H'*H)*H'*X
  yest = Aest.*exp(-alfai.*(time-tmax));
  plot(time,yest,'g-')
  %%%compute ydata*(1/exp(-alfai.*t))
  plot(time,ydata.*(1./exp(-alfai.*(time-tmax))),'m-')
  %%add alfai to estimate of alfa
  alfa = alfa + (1/8)*alfai;
end





% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
