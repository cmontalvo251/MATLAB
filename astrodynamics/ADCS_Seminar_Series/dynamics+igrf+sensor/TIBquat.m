function R = TIBquat(q0123)
%compute R such that v(inertial) = TIB v(body)

q0 = q0123(1);
q1 = q0123(2);
q2 = q0123(3);
q3 = q0123(4);

R = [(q0^2+q1^2-q2^2-q3^2) 2*(q1*q2-q0*q3)  2*(q0*q2+q1*q3);
      2*(q1*q2+q0*q3) (q0^2-q1^2+q2^2-q3^2) 2*(q2*q3-q0*q1);
      2*(q1*q3-q0*q2) 2*(q0*q1+q2*q3) (q0^2-q1^2-q2^2+q3^2)];

% Matrix originally adopted from Boom 2010 - Mark Costello
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
