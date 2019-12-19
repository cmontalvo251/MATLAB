%%How many sundays fell on the first of the month in the 20th
%century
clear
clc
close all

tic

Months = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep', ...
          'Oct','Nov','Dec'};

DaysPMo = [31 28 31 30 31 30 31 31 30 31 30 31];

Days = {'Mon','Tues','Wed','Thurs','Fri','Sat','Sun'};

dayinmonth = 1;
monthloc = 1;
dayspmoloc = 1;
daysloc = 1;
year = 1900;

currentday.day = Days{1};
currentday.month = Months{1};
currentday.year = year;
currentday.dayinmonth = 1;
maxdaysinmonth = DaysPMo(1);

if ~mod(year,400)
   leapyear = 1;
elseif ~mod(year,100)
   leapyear = 0;
elseif ~mod(year,4)
   leapyear = 1;
else
   leapyear = 0;
end

answer = 0;

while year < 2001
   %%Check for leap year
   if leapyear
      DaysPMo(2) = 29;
   else
      DaysPMo(2) = 28;
   end

   currentday;
   %%Add 1 day
   daysloc = daysloc + 1;
   dayinmonth = dayinmonth + 1;

   %%Check end of week
   if daysloc == 8
      daysloc = 1;
   end

   %%Check end of month
   if dayinmonth > maxdaysinmonth
      monthloc = monthloc + 1;
      dayinmonth = 1;
   end

   %%Check End of Year
   if monthloc > 12
      monthloc = 1;
      year = year + 1;
   end
   maxdaysinmonth = DaysPMo(monthloc);

   %%Save new day
   currentday.day = Days{daysloc};
   currentday.month = Months{monthloc};
   currentday.year = year;
   currentday.dayinmonth = dayinmonth;

   if ~mod(year,400)
      leapyear = 1;
   elseif ~mod(year,100)
      leapyear = 0;
   elseif ~mod(year,4)
      leapyear = 1;
   else
      leapyear = 0;
   end

   if year >= 1901
      %%Check for sunday on 1st of the month
      if strcmp(currentday.day,'Sun')
         if dayinmonth == 1
            answer = answer + 1;
         end
      end
   end

end
toc

answer