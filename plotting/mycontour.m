function mycontour(pcMAT,levels,x,y)

[xx,yy] = meshgrid(x,y);

maxin = max(max(pcMAT));
minin = min(min(pcMAT));

step = -(maxin-minin)/levels;

[r,c] = size(pcMAT);
idx = 0;
colors = {'b-','r-','g-','m-','b--','g--','r--','m--','b-.','r-.','g-.','m-.'};
levels = {};
for p = maxin:step:minin
  levels = [levels;num2str(p)];
  x = [];
  y = [];
  z = [];
  idx = idx + 1;
  for ii = 1:r-1
    for jj = 1:c-1
      %%You are now in a square. You need to see if p is in between
      fourcorners = [pcMAT(ii,jj) pcMAT(ii+1,jj) pcMAT(ii,jj+1) pcMAT(ii+1,jj+1)];
      if sum(fourcorners<p)
	%%This plane intersects p
	for ll = 0:1
	  z1 = pcMAT(ii+ll,jj+ll);
	  x1 = xx(ii+ll,jj+ll);
	  y1 = yy(ii+ll,jj+ll);
	  % plot3(x1,y1,z1,'r*');
	  for mm = 0:1
	    z2 = pcMAT(ii+mm,jj+1-mm);
	    if (z1 < p && z2 < p) || (z1 > p && z2 > p)
	      %%do nothing
	    else
	      x2 = xx(ii+mm,jj+1-mm);
	      y2 = yy(ii+mm,jj+1-mm);
	      %%Now find x,y such that z = p
	      l = [x2-x1;y2-y1;z2-z1];
	      l = l./norm(l);
	      lambda = (p-z1)/l(3);
	      xstar = lambda*l(1)+x1;
	      ystar = lambda*l(2)+y1;
	      %plot3(xstar,ystar,p,'b*');
	      x = [x;xstar];
	      y = [y;ystar];
	      z = [z;p];
	      % plot3(x2,y2,z2,'r*');
	    end
	  end
	end
      end
    end
  end
  [x,index] = sort(x);
  y = y(index);
  plot3(x,y,z,colors{idx},'LineWidth',2)
end
%mesh(xx,yy,pcMAT)
legend(levels)
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
