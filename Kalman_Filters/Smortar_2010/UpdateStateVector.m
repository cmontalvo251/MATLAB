function UpdateStateVector()

global pvector xstateold NumKalman xstatenew xnew
global GPSupdatecounter Statesmeasured Pnew C R xold
global LinearPlant

%%Update State Using Kalman Filter
%%Construct Covariance Matrix
pvector = xold(NumKalman+1:end);
xstateold = xold(1:NumKalman);
Pold = zeros(NumKalman,NumKalman);
for jj = 2:NumKalman
  mark = (NumKalman+1)-jj;
  Pold([1:mark],[jj:NumKalman]) = Pold([1:mark],[jj:NumKalman]) + diag(pvector(NumKalman+1:(NumKalman+mark)));
  pvector(NumKalman+1:(NumKalman+mark)) = [];
end
Pold = diag(pvector) + Pold' + Pold;

%%%%%Kalman Gain

K = Pold*C'*inv(R + C*Pold*C');
if isnan(K(1,1)) || isinf(K(1,1))
  K = zeros(NumKalman,NumObservedStates);
end

%%%%%%%%%%%%%%%%

%%%%%%%%%State Update

%%Statesmeasured is [x,y,z,xdot,ydot,zdot] <- GPS provides this
xstatenew = xstateold + K*(Statesmeasured(:,GPSupdatecounter)-C*xstateold);
GPSupdatecounter = GPSupdatecounter + 1;
xstateold = xstatenew;


%%%%%%%%%%%%%%%

%%%%%%%%%%Covariance Update

Pnew = Pold + C'*inv(R)*C;
if isnan(Pnew(1,1)) || isinf(Pnew(1,1))
  Pnew = zeros(NumKalman,NumKalman);
end

%%Deconstruct Covariance Matrix

pvector = xold(NumKalman+1:end);
loc = 1;
for jj = 1:NumKalman
  mark = NumKalman+1-jj;
  vec = diag(Pnew([1:mark],[jj:NumKalman]));
  pvector(loc:loc+length(vec)-1) = vec;
  loc = loc + length(vec);
end

%%%%%%%%%%%%

xold = [xstateold;pvector];
xnew = xold;

  
