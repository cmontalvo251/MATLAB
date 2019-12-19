function quiver3D(x,y,u,v,w,s)
%%%plot3D(x,y,z,data,minr,maxr) data x,y,z are all vectors and data is a 3
%%%dimensional matrix. minr and maxr are the maximum radii of the
%circles to plot

[r,c] = size(u);

%%Compute Maximum Length
dx = x(2)-x(1);
dy = y(2)-y(1);
maxlength = min([dx,dy]);
Vmax = max(max(sqrt(u.^2+v.^2+w.^2)));

ratio = (maxlength/2)/Vmax;

for ii = 1:c
  for jj = 1:r
      l = [u(jj,ii),v(jj,ii),w(jj,ii)];
      norml = norm(l);
      lhat = l./norml;
      scale = ratio*norml*s;
      rp = [x(ii),y(jj),0] + lhat.*scale;
      plot3([x(ii) rp(1)],[y(jj) rp(2)],[0 rp(3)],'b-','LineWidth',2)
      plot3(rp(1),rp(2),rp(3),'bx','MarkerSize',10)
      hold on
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
