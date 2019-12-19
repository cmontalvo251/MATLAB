%purge

disp('Resetting Color Order')

default_color_order = [         0         0    1.0000;
         0    0.5000         0;
    1.0000         0         0;
         0    0.7500    0.7500;
    0.7500         0    0.7500;
    0.7500    0.7500         0;
    0.2500    0.2500    0.2500]

set(0,'DefaultAxesColorOrder',default_color_order);

disp('Color Order Reset to Default')

% Copyright - Carlos Montalvo 2017
% You may freely distribute this file but please keep my name in here
% as the original owner