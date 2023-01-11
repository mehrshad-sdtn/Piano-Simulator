clc;clear; close all

disp('SBU-MATLAB-2022');
disp('HELP: PRESS ANY OF THE KEYBOARD ALPHABET KEYS FROM q (LOW) to m (HIGH)');
disp('ENJOY THE PIANO SOUND!');

%%%% mapping key chars to note numbers
keys = {'q' 'w' 'e' 'r' 't' 'y' 'u' 'i' 'o' 'p' 'a' 's' 'd' 'f' 'g' 'h' 'j' 'k' 'l' 'z' 'x' 'c' 'v' 'b' 'n' 'm'};
note_nums = [16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41];
note_map = containers.Map(keys, note_nums);  

% uncomment the code below to create sample music (sample.wav)
%save_sequence(['l' 'k' 'a' 'l' 'k' 's' 'l' 'k' 'a'], note_map);

waitforbuttonpress;     
ch = get(gcf,'CurrentCharacter');   
while ch ~= '!'
    n = note_map(ch);
    play_note(n);
    waitforbuttonpress; 
    ch = get(gcf,'CurrentCharacter');   
end

%%%%%%%%%%%%%%%%%%%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% function for creating sample music given a sequence of alphabets
function save_sequence(vect, note_map)
 Fs = 44100;
 notes = [];
 for i=1:length(vect)
     note = note_map(vect(i));
     notes = [notes play_note(note)];
 end
 audiowrite('sample.wav', notes, Fs);
end

%%%% function for playing a single note given it's note number
function wave = play_note(n)
  Fs = 44100; % Hz
  t = 0 : 1/Fs : 3;
  freq = 2.^((n-49)/12) .* 440;

  y = add_harmonics(freq, t);
  y = y + (y .* y .* y);
  wave = y/6;
  soundsc(wave,Fs);
end

%%%% creating the piano sound (creating fundamental tone and adding
%%%% harmonics
function out = add_harmonics(frequency, time)
  out = 0;
  for i=1:7
      out = out + sin(i * 2 * pi * frequency * time) .* exp(-0.0004 * 2 * pi * frequency * time) / (2 ^ (i -1));
  end
end

