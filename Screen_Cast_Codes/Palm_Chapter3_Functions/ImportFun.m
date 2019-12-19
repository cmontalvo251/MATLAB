%%%%File I/O Input/Output
clear %%Clears the workspace
clc %%%Clears the command window
close all %$%$Closes all windows

%A = [5 4 6; 1 2 3;7 8 9];


%dlmwrite('Test.txt',A,'delimiter',',','precision','%.3f'); %%%Delimited File
%%%A delimiter is a character that separates number


%dlmwrite('Test.txt',A)
%%%The default is a comma

%dlmwrite('Test.txt',A,'delimiter',' ')
%%%Change the delimiter to a space

%dlmwrite('Test.txt',A,'delimiter',' ','precision','%.3f')
%%% 12.5f  --  a field width of 12, number of digits of 5 and f is fixed
%%% point notation
%%%If you leave the field number blank it will adapt

%dlmwrite('Test.txt',A,'delimiter',' ','precision','%.3f','newline','pc')
%%%THis will print a new line for every row

%%%What if want to output A and B
%B = magic(4); %%Generates a 3x3

%dlmwrite('Test.txt',[A;B],'delimiter',' ','precision','%.3f','newline','pc')

%%or

%dlmwrite('Test.txt',A,'delimiter',' ','precision','%.3f','newline','pc')

%dlmwrite('Test.txt',B,'delimiter',' ','precision','%.3f','newline','pc','-append')


%A = dlmread('Test.txt');

[data,txt,all] = xlsread('Test.xls');