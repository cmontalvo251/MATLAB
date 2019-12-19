function out = convertENG2SI(infile,outfile)
	
%%assume first column is time
data = dlmread(infile);
[r,c] = size(data);
dist = 3.28; %meters to feet 1 m = 3.28 ft
ang = 1; %
force = 4.44822;  %Newtons to lbf (1 lbf = 4.448 N)

data(:,2) = data(:,2)./dist; %x
data(:,3) = data(:,3)./dist; %y
data(:,4) = data(:,4)./dist; %z
data(:,5) = data(:,5).*ang; %phi
data(:,6) = data(:,6).*ang; %theta
data(:,7) = data(:,7).*ang; %psi
data(:,8) = data(:,8)./dist; %u
data(:,9) = data(:,9)./dist; %v
data(:,10) = data(:,10)./dist; %w
%pqr 11,12,13
data(:,14) = data(:,14).*force; 
data(:,15) = data(:,15).*force;
data(:,16) = data(:,16).*force;
data(:,17) = (data(:,17)./dist).*force; 
data(:,18) = (data(:,18)./dist).*force;
data(:,19) = (data(:,19)./dist).*force;

out = data;

if nargin > 1
  dlmwrite(outfile,out,'delimiter',' ','precision','%.20f','newline','pc');
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
