close all

global mark1 mark2

delx = 0.1;

USETERRAIN = 0;
%USEPATCH = 0;

if USETERRAIN
    xterrain = dlmread('Terrain/xterrain.txt');
    yterrain = dlmread('Terrain/yterrain.txt');
    zterrain = dlmread('Terrain/zterrain.txt');
    %%%Interpolate at y = 0
    xvec = xterrain(:,1);
    yvec = yterrain(1,:)';
    zvec = 0*yvec;
    mark1 = [1 2];
    mark2 = [1 2];
    N = (xvec(end)-xvec(1))/delx;
    xmountain = linspace(xvec(1),xvec(end),N)';
    ymountain = 0*ones(length(xmountain),1);
    zmountain = 0*xmountain;
    for idx = 1:length(xmountain)
        zmountain(idx) = interpsave2(xvec,yvec,zterrain',xmountain(idx),ymountain(idx));
    end
    plottool(1,'Mesh',18,'x','y','z');
    mesh(xterrain,yterrain,zterrain)
    hold on
    plot3(xmountain,ymountain,zmountain,'k-','LineWidth',2)
elseif USEPATCH || INTERPPATCHON
    xterrain = dlmread('Terrain/xterrain.txt');
    xvec = xterrain(:,1);
    N = (xvec(end)-xvec(1))/delx;
    filename = 'Terrain/Rocky_Terrain.stl';
    [xp,yp,zp,cp] = stlread(filename);
    %plottool(1,'Patch',18,'x','y','z');
    %patch(xp,yp,zp,zp,'edgecolor','k')
    centroidsxy = computecentroids(xp,yp,zp);
    xmountain = linspace(xvec(1),xvec(end),N)';
    ymountain = 0*ones(length(xmountain),1);
    zmountain = 0*xmountain;
    for idx = 1:length(xmountain)
        zmountain(idx) = interppatch(centroidsxy,xp,yp,zp,xmountain(idx),ymountain(idx));
    end
else
    L = 1000;
    xmountain = 0:delx:L;
    amp = [1 1 0.1 0.01];
    freq = [1 2 10 100];
    ymountain = 0*xmountain;
    NWAVES = length(amp);
    for idx = 1:NWAVES
        ymountain = ymountain + amp(idx)*sin(freq(idx)*pi*xmountain/100);
    end
end

if ~INTERPPATCHON
    plottool(1,'Mountain',14,'X (m)','AGL (m)');
    plot(xmountain,zmountain,'b-*','LineWidth',2)
    axis equal
    
    theta_mountain = get_theta(xmountain,zmountain,xmountain);
    
    plottool(1,'Theta',12,'Time (sec)','\theta (deg)');
    plot(xmountain,theta_mountain*180/pi,'b-*','LineWidth',2)
    
    dlmwrite('Terrain/xmesh.txt',xmountain)
    dlmwrite('Terrain/ymesh.txt',ymountain)
    dlmwrite('Terrain/zmesh.txt',zmountain)
end