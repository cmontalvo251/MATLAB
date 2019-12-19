function plot3D(x,y,z,data,minr,maxr)
%%%plot3D(x,y,z,data,minr,maxr) data x,y,z are all vectors and data is a 3
%%%dimensional matrix. minr and maxr are the maximum radii of the
%circles to plot

[r,c,w] = size(data);

maxF = max(max(max(data)))
minF = min(min(min(data)))

if maxF ~= 0
  slope = (maxr-minr)/(maxF-minF);

  for ii = 1:r
    for jj = 1:c
      for ll = 1:w
	fstar = data(ii,jj,ll);
	radius = minr + slope*(fstar-minF);
	if radius == 0 || radius < 0
	  radius = minr
	end
	plot3(x(ii),y(jj),z(ll),'bo','MarkerSize',radius)
	hold on
      end
    end
  end
  dx = (maxF-minF)/2;
  fstar = minF:dx:maxF;
  radius = minr + slope*(fstar-minF);
  plottool(1,'Rad Scale',12,'F','r')
  plot(fstar,radius)
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
