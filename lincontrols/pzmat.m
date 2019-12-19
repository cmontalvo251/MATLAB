function pzmat(A)
%%Plots poles of a Matrix

val = eig(A);

plottool(1,'Pole Map',12,'Real','Imaginary')

plot(real(val),imag(val),'b*')

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
