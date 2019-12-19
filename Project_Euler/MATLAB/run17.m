%%Problem 17
%%If you say the words 1 through 10 like one, two, three and add up
%%the number of words how many letters are there from one to one
%thousand
clear
clc
tic

%%1-9
one=3;
two=3;
three=5;
four=4;
five=4;
six=3;
seven=5;
eight=5;
nine=4;

%%N1-9
N19 = 190;
None19 = 191;

%%10-19
ten=3;
eleven=6;
twelve=6;
thirteen=8;
fourteen=8;
fifteen2=7;
sixteen=7;
seventeen=9;
eighteen=8;
nineteen=8;

%N10-19
N1019 = 10;

%20,30,40,etc
twenty=6;
thirty=6;
forty=5;
fifty=5;
sixty=5;
seventy=7;
eighty=6;
ninety=6;

%N20-90
N2090 = 100;

%Extra Words
hundred=7;
thousand=8;
and=3;

%Nextra
Nhundred = 900;
Nthousand = 1;
Nand = 891;

%%Total

Ntotal = None19*one + N19*(two+three+four+five+six+seven+eight+nine) ...
	 + N1019*(ten+eleven+twelve+thirteen+fourteen+fifteen2+sixteen+ ...
	  seventeen+eighteen+nineteen) + N2090*(twenty+ ...
	  thirty+forty+fifty+sixty+seventy+eighty+ninety) + ...
	 Nhundred*hundred+ Nthousand*thousand + Nand*and
						  
toc