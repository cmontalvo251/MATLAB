%%%%Startup file
clear
clc
close all

blackboxdir = '/home/carlos/Dropbox/BlackBox/';

%On linux put this file in your /home/user directory
%On Windows put this in your C:\Users\User\Documents\MATLAB
%On Mac put this in /home/user directory
%For Octave you need to navigate to the following directory
%C:\Octave\Octave-4.0.0\share\octave\site\m\startup
%Then you need to edit the octaverc file and add the startup file
%To that octaverc file. You can either copy and past the entire
%thing in there or just copy this file to that directory
%If you're on linux you need to find the root directory 
%of octave. It shouldn't be that hard (try '$ which octave')
%In octave make sure to name this file mystartup.m since startup.m
%apparently shadows another built-in function. 
%In linux the octave root directory is
%/usr/share/octave/site/m/startup/
%What you want to do is add a line of code called 
%mystartup to the file octaverc
%then make a symbolic link
%ln -s /home/carlos/Dropbox/BlackBox/startup.m /usr/share/octave/site/m/startup/mystartup.m

%%%%%%%DROPBOX FOLDERS%%%%%%%%%%%%%%%%
A = dir(blackboxdir);

eval(['addpath ',blackboxdir])

for ii = 3:length(A)
  if A(ii).isdir
    d = ['addpath ',blackboxdir,A(ii).name];
    eval(d)
  end
end


%%%%%%%%%DEFAULTS%%%%%%%%%%%%%%%%%%%%%

%set(0,'defaultAxesFontName','Times New Roman')
%set(0,'DefaultFigureWindowStyle','docked')

set(0,'defaultFigureColor','w')
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultAxesXGrid','on')
set(0,'DefaultAxesYGrid','on')
set(0,'defaultLineLineWidth',2)

%%%Color Order and LineStyle Order
%default_co = get(gca,'ColorOrder');
%close all
%black = [0 0 0]+0.25;
%set(0,'DefaultAxesColorOrder',black);
%set(0,'defaultAxesLineStyleOrder','-|--|:')

disp('Startup File Loaded')
disp(['Version = ',version])

%%%%%%%LOAD OCTAVE PACKAGES%%%%%%%%%

try
   pkg load optim %apt-get install octave-optim
   disp('Optim Package Loaded')

   pkg load symbolic %You need python-sympy then you can run pkg
                     %install -forge symbolic
   %Do download more packages type in a terminal
   % $ sudo apt-get install octave-symbolic  
   %
   disp('Symbolic Package Loaded')
   
   pkg load control %to install the control tool box I just googled 
   %octave control package and downloaded it from sourceforge. Then
   %I ran '$ pkg install control-3.0.0.tar.gz'
   disp('Control Package Loaded')

   pkg load odepkg %to install type 
   % $ sudo apt-get install octave-odepkg
   disp('Ode Package Loaded')
   
   pkg load image %%%apt-get install octave-image
   disp('Image Package Loaded')
   
   pkg load signal %%%apt-get install octave-signal
   disp('Signal Package Loaded')
catch me
   disp('No Packages Loaded')
end

% x = rand(100,100);
% x(x<0.5) = 0;
% x(x>=0.5) = 1;
% spy(x);

clear

% Uncomment this if you want to start in a specific folder 
%cd /home/carlos/Desktop

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
