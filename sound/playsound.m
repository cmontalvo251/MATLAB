%Fs = 44100;      %# Samples per second
%toneFreq = 200;  %# Tone frequency, in Hertz
%nSeconds = 0.5;   %# Duration of the sound
%y = sin(linspace(0, nSeconds*toneFreq*2*pi, round(nSeconds*Fs)));

%When played at 1 kHz using the SOUND function, this vector will generate a 50 Hz tone for 2 seconds:

%sound(y, Fs);  %# Play sound at sampling rate Fs

%The vector can then be saved as a wav file using the WAVWRITE function:

%wavwrite(y, Fs, 8, 'tone.wav');  %# Save as an 8-bit, 1 kHz signal

if isunix
  system('mpg123 ~/Dropbox/BlackBox/sound/horn.mp3');
else
  system('C:/Users/carlos/Dropbox/BlackBox/mpg123 C:/Users/carlos/Dropbox/BlackBox/horn.mp3');
end

%[y,Fs] = mp3read('C:/Users/carlos/Dropbox/BlackBox/horn.mp3');
%sound(y,Fs)

%wavwrite([120*da(:,1);120*da(:,1)],20000,'temp.wav')

%!rm tone.wav

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
