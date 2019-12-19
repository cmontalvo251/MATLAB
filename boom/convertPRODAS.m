function out = convertPRODAS(infile,outfile,units)
%function out = convertPRODAS(infile,outfile)
%%This will take in a prodas file Convert everything to
%normal aerospace convention and output it to a file in
%english units
	
%%Forces and moments in inertial frame (Forces do include gravity)

%units = 2; %1 for SI and 2 for English(units of output file)
data = dlmread(infile);
[r,c] = size(data);
if units == 2
  dist = 3.28; %meters to feet 1 m = 3.28 ft
  ang = pi/180; %deg to radians 1 deg = pi/180 rad
  force = 4.44822;  %Newtons to lbf (1 lbf = 4.448 N)
elseif units == 1
  dist = 1;
  ang = pi/180;
  force = 1;
end

% Column 2: t boom = t prodas (data in sec) 
data(:,3) = data(:,3).*dist; % Column 3: x boom = x prodas (data in meters) 
data(:,4) = -data(:,4).*dist;% Column 4: y boom = - y prodas (data in meters) 
data(:,5) = -data(:,5).*dist;% Column 5: z boom = - z prodas (data in meters)
data(:,6) = data(:,6).*ang; % Column 6: phi boom = phi prodas (data in deg) 
data(:,7) = -data(:,7).*ang; % Column 7: theta boom = - theta prodas  (data in deg)
data(:,8) = -data(:,8).*ang; % Column 8: psi boom = - psi prodas (data in deg) 

phi = data(:,6); %%phi,theta,psi in radians
theta = data(:,7);
psi = data(:,8);

%%Now we must rotate the velocities to the body frame
for ii = 1:r
  data(ii,9) = data(ii,9).*dist; % Column 9: Vx boom = Vx prodas (data in m/s, in prodas inertial axis) 
  data(ii,10) = -data(ii,10).*dist; % Column 10: Vy boom = - Vy prodas (data in m/s, in prodas inertial axis) 
  data(ii,11) = -data(ii,11).*dist; % Column 11: Vz boom = - Vz prodas (data in m/s, in prodas inertial axis) 
  TBodytoI = [[cos(psi(ii))*cos(theta(ii)) -cos(phi(ii))* ...
	     sin(psi(ii))+cos(psi(ii))*sin(phi(ii))*sin(theta(ii)) ...
	     cos(phi(ii))*cos(psi(ii))*sin(theta(ii))+sin(phi(ii))* ...
	     sin(psi(ii))];[cos(theta(ii))*sin(psi(ii)) ...
		    cos(phi(ii))*cos(psi(ii))+sin(phi(ii))* ...
		    sin(psi(ii))*sin(theta(ii)) -cos(psi(ii))* ...
		    sin(phi(ii))+cos(phi(ii))*sin(psi(ii))* ...
		    sin(theta(ii))];[-sin(theta(ii)) ...
		    cos(theta(ii))*sin(phi(ii)) cos(phi(ii))* ...
                    cos(theta(ii))]];

  TItoBody = TBodytoI'; %%%Body to I is the transpose of the Inertial
                      %to body reference frame
  VxVyVz = [data(ii,9);data(ii,10);data(ii,11)];
  uvw = TItoBody*VxVyVz;
  data(ii,9) = uvw(1);
  data(ii,10) = uvw(2);
  data(ii,11) = uvw(3);
  
  data(ii,15) = data(ii,15)./force; % Column 15: Fx boom = Fx prodas (data in N) 
  data(ii,16) = -data(ii,16)./force; % Column 16: Fy boom = - Fy prodas (data in N) 
  data(ii,17) = -data(ii,17)./force; % Column 17: Fz boom = - Fz prodas (data in N) 
  data(ii,18) = (data(ii,18).*dist)./force; % Column 18: Mx boom = Mx prodas (data in N m) 
  data(ii,19) = -(data(ii,19).*dist)./force; % Column 19: My boom = - My prodas (data in N m) 
  data(ii,20) = -(data(ii,20).*dist)./force; % Column 20: Mz boom = - Mz prodas (data in N m)

  FxFyFz = [data(ii,15);data(ii,16);data(ii,17)];
  
  LMNinertial = [data(ii,18:20)]';
  
  XYZbody = TItoBody*FxFyFz;
  LMNbody = TItoBody*LMNinertial;
  
  data(ii,15) = XYZbody(1);
  data(ii,16) = XYZbody(2);
  data(ii,17) = XYZbody(3);
  
  data(ii,18) = LMNbody(1);
  data(ii,19) = LMNbody(2);
  data(ii,20) = LMNbody(3);
  
end


data(:,12) = data(:,12);% Column 12: p boom = p prodas (data in rad/s, in prodas body axis) 
data(:,13) = -data(:,13); % Column 13: q boom = - q prodas (data in rad/s, in prodas body axis) 
data(:,14) = -data(:,14); % Column 14: r boom = - r prodas (data in rad/s, in prodas body axis) 

out = data(:,2:end); %1st column is index

if nargin > 1
  dlmwrite(outfile,out,'delimiter',' ','precision','%.20f','newline','pc');
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
