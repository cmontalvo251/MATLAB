function xout = NoRoll(xin,flag)
%function xout = NoRoll(xin,flag)

if strcmp(flag,'Quat')
  ptp = quat2euler(xin(:,4:7));
  phi = ptp(:,1);
  u = xin(:,8);
  v = xin(:,9);
  w = xin(:,10);
  p = xin(:,11);
  q = xin(:,12);
  r = xin(:,13);  
  vtilde = v.*cos(phi) - w.*sin(phi);
  wtilde = v.*sin(phi) + w.*cos(phi);
  qtilde = q.*cos(phi) - r.*sin(phi);
  rtilde = q.*sin(phi) + r.*cos(phi);  
  %vtilde = v;
  %wtilde = w;
  %qtilde = q;
  %rtilde = r;
  %V = sqrt(u.^2 + v.^2 + w.^2);
  xout = [xin(:,1:3),ptp,u,vtilde,wtilde,p,qtilde,rtilde];
else
  ptp = xin(:,4:6);
  phi = ptp(:,1);
  u = xin(:,7);
  v = xin(:,8);
  w = xin(:,9);
  p = xin(:,10);
  q = xin(:,11);
  r = xin(:,12);  
  vtilde = v.*cos(phi) - w.*sin(phi);
  wtilde = v.*sin(phi) + w.*cos(phi);
  qtilde = q.*cos(phi) - r.*sin(phi);
  rtilde = q.*sin(phi) + r.*cos(phi);  
  %vtilde = v;
  %wtilde = w;
  %qtilde = q;
  %rtilde = r;
  %V = sqrt(u.^2 + v.^2 + w.^2);
  xout = [xin(:,1:3),ptp,u,vtilde,wtilde,p,qtilde,rtilde];
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
