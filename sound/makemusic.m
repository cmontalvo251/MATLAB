%%%MAKING MUSIC
close all
clear

samplingFrequency = 8192;

notelength = 0.08;
tnote = linspace(0,notelength,8192*notelength); %%seconds
freq = 200; %%Hz
amp = 1;
ynote1 = amp*cos(2*pi*freq*tnote);
ynote2 = amp*cos(2*pi*300*tnote);
ynote3 = amp*cos(2*pi*350*tnote);
ynote4 = amp*cos(2*pi*400*tnote);

ynote_all = [ynote1,ynote2,ynote3,ynote4];

%%%%These next lines of code will only work on a linux machine
wavwrite(ynote_all,samplingFrequency,'test.wav');
system('aplay test.wav')

%%%if you want this to work on a Windows machine use the following commands
%sound(ynote_all,samplingFrequency)

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
