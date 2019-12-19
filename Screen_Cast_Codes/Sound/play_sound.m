function play_sound(name,start_c)

%clear
%clc
close all

format long g

%%%Let's play the C major scale (CDEFGAB)
%%%To get the frequencies we start with middle c
%low_c = 65.406;
%bass_c = 130.813;
%middle_c = 261.6;

%start_c = low_c;

%%%moving up a note is equivalent to middle_c*2^(1/12)
%%%thus 
%middle_c*2^(1/12) = C sharp
%middle_c*2^(2/12) = D
%middle_c*2^(3/12) = D sharp
%middle_c*2^(4/12) = E
%For the key of C we have CDEFGAB thus
note_octaves = [0 2 4 5 7 9 11];

%c_major_freq = middle_c*2.^(note_octaves/12)
%[261.6 293.665 329.638 349.228 391.995 440 493.883]; %%%note frequency

%%%We need to make a sine wave at these frequencies

%%%Note the sample frequency is 8192 Hz /sec. Which means if we want a note
%%%that lasts 1 second we need 8192 data points
FS = 8192;
note_length = 0.2; %%seconds

t = linspace(0,note_length,FS*note_length);

%%%%Remember that natural frequency is 2*pi*f thus our sin wave is:
y = [];
alphabet = 'abcdefghijklmnopqrstuvwxyz';

for ll = 1:length(name)
    idx = find(name(ll) == alphabet,1);
    octave = 0;
    %%Remember that 8 is an extra octave thus we should hear middle c and
    %%then an octave higher
    while idx > length(note_octaves) %%If we overwrap we need to up the octave
        idx = idx - length(note_octaves);
        octave = octave + 1;
    end
    idx;
    octave;
    name(ll);
    freq = start_c*2.^(note_octaves(idx)/12+octave);
    y = [y,sin(2*pi*freq*t)];
end

plot(y)

%sound(y,FS)

wavwrite(y,FS,'test.wav');

!aplay test.wav

%%%So to make this work what we want to do is map every letter of the
%%%alphabet to a note in the key of c. That is A = middle C, B = D, C = E
%%%and so on. Might be pretty cool. Perhaps certain names sound cool and
%%%others do not. It will also be a way to learn everyone's name.