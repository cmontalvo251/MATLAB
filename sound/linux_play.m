function linux_play(y,FS)
%%%y is the audio vector and FS is the frequency.
version -release;
ver = ans;

if ver == '2009a'
  system('rm music.wav');
  %disp('You must play this on version 2014')
  wavwrite(y,FS,'music.wav');
  system('aplay music.wav');
else
  sound(y,FS)
end