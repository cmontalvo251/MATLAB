function output = potential2D(input,gridsize,check)
%%give this function a 2x2 grid and it will create the potential
%%field based on the initial guess of input
%%Function will iterate until only 1 local min is found

%Laplacian code with 2D, 4 sided connectivity
%%written by Jack Mooney
%%Altered by Carlos Montalvo

global absmin

[N,N] = size(input);
xvec = 1:N;
yvec = 1:N;

[xx,yy] = meshgrid(xvec,yvec);

%%Initialize Variables
INTPLOT = 0;
%PLOT = 0;
maxiterations = 1;
Numdsample = 0;
Numusample = Numdsample;

%%Save absolute minimum
absmin = -min(min(input));

if INTPLOT
   mesh(xx,yy,input);
   hold off
   drawnow
   pause
end
localmin = 10;
ismooth = 1;
while localmin > 2
  input = smooth(input,N,maxiterations);
  %disp('Smoothed')
   if INTPLOT
     mesh(xx,yy,input)
     hold off
     pause
   end
  ismooth = 1 + ismooth;
  %%Check for local min
  if ismooth > check
    ismooth;
    localmin = checkmin(input);
    if INTPLOT
      mesh(xx,yy,input)
      hold off
      pause
    end
  end
end
%disp('Initial smooth complete.')
disp(['Smoothing Iterations = ',num2str(ismooth)])


if INTPLOT
   mesh(xx,yy,input)
   hold off
   pause
end

% if Numusample > 0

%   %Coarsen the grid and smooth
%   for i = 1:Numdsample
%     input = downsample(input);
%     N = N/2;
%     disp('Downsampled');
%     if INTPLOT
%       [xx,yy] = meshgrid(1:N,1:N);
%       mesh(xx,yy,input);
%       hold off
%       drawnow
%       %pause
%     end
%     input = smooth(input,N,maxiterations);
%     disp('Smoothed')
%     if INTPLOT
%       mesh(xx,yy,input);
%       hold off
%       drawnow
%       %pause
%     end
%   end
%   disp('Coarsening complete.')
%   if INTPLOT
%     mesh(xx,yy,input);
%     hold off
%     drawnow
%     %pause
%   end

%   %Refine the grid and smooth
%   for ihat = 1:Numusample
%     input = upsample(input);
%     disp('Upsampled')
%     %Restore fidelity to waypoint potentials
%     %???
    
%     N = N*2; 
%     if INTPLOT
%       [xx,yy] = meshgrid(1:N,1:N);
%       mesh(xx,yy,input);
%       hold off
%       drawnow
%       %pause
%     end
%     input = smooth(input,N,maxiterations);
%     disp('Smooth')
%     if INTPLOT
%       mesh(xx,yy,input);
%       hold off
%       drawnow
%       %pause
%     end
%   end
% end

% disp('Refining complete.')

% toc
output = input;

% %%Plotting Routine

% %%Potential Field
% [xx,yy] = meshgrid(1:N,1:N);
% mesh(xx,yy,input);

% %%Streamlines
%[gradx, grady] = fdgradient(input,gridsize);
% interval = 3;
% [startx starty] = meshgrid(1:interval:N,1:interval:N);
% disp('Plotting Streamlines');
% plottool(1,'Streamlines',12,'x','y')
% streamline(1:N,1:N,-gradx,-grady,startx,starty);

% if PLOT
%   %%Plot Gradient Field
%   plottool(1,'dfdx',12,'x','y','','',[-36 22])
%   mesh(xx,yy,gradx)
%   plottool(1,'dfdy',12,'x','y','','',[-36 22])
%   mesh(xx,yy,grady)
% end

function localmin = checkmin(WP)
%checks for localminima

[m,n] = size(WP);

localmin = 0;

for ii = 2:m-1
  for jj = 2:n-1
    val = WP(ii,jj);
    vec = [WP(ii+1,jj) WP(ii,jj-1) WP(ii,jj+1) WP(ii-1,jj)];
    if val <= vec
      localmin = localmin + 1;
    end
  end
end

function WPout = downsample(WPin)

global absmin

[m,n] = size(WPin);

mout = m/2;
nout = n/2;

WPout = zeros(mout,nout);

for i = 1:mout
  for j = 1:nout
    if WPin(2*i-1,2*j-1) == -absmin || WPin(2*i-1+1,2*j-1) == -absmin ||...
	  WPin(2*i-1,2*j+1-1) == -absmin ||WPin(2*i+1-1,2*j+1-1) == -absmin
      WPout(i,j) = -absmin;
    elseif WPin(2*i-1,2*j-1) == 0 || WPin(2*i-1+1,2*j-1) == 0 ||...
	  WPin(2*i-1,2*j+1-1) == 0 ||WPin(2*i+1-1,2*j+1-1) == 0
      WPout(i,j) = 0;
    else
      WPout(i,j) = (WPin(2*i-1,2*j-1) + WPin(2*i-1+1,2*j-1)...
		     +WPin(2*i-1,2*j+1-1)+WPin(2*i+1-1,2*j+1-1))/4;
    end
  end
end


function WPout = smooth(WPin,N,maxiterations)

global absmin

[m,n] = size(WPin);
WPout = WPin;

odd = 1;

for index = 1:maxiterations

  if odd == 1
    %%start from top left
    for i = 2:m-1
      for j = 2:n-1
         if WPin(i,j) == 0 || WPin(i,j) == -absmin
            %Do nothing
         else
            WPout(i,j) = (WPin(i+1,j) +WPin(i-1,j) +WPin(i,j+1) +WPin(i,j-1))/4;
         end
      end
    end
    odd = 0;
  elseif odd == 0
     %%start from bottom right
     for ihat = 2:m-1
        for jhat = 2:n-1
           i = m+1 - ihat;
           j = n+1 - jhat;
           if WPin(i,j) == 0 || WPin(i,j) == -absmin
              %Do nothing
           else
              WPout(i,j) = (WPin(i+1,j) +WPin(i-1,j) +WPin(i,j+1) +WPin(i,j-1))/4;
           end
        end
     end
     odd = 1;
  end
  WPin = WPout;
end


function WPout = upsample(WPin)

[m,n] = size(WPin);

mout = m*2;
nout = n*2;

WPout = zeros(mout,nout);

for i = 1:m
  for j = 1:n
    temp =WPin(i,j);
    WPout(2*i,2*j) = temp;
    WPout(2*i-1,2*j) = temp;
    WPout(2*i,2*j-1) = temp;
    WPout(2*i-1,2*j-1) = temp;
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
