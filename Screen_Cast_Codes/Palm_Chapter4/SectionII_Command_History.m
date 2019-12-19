cell_array = {'Names','Marquez','Katherine','Conner'}
whos
Computers = {'Types','Gateway','Dell','Dell'}
cell_array
whos
x = [4 5]'
y = [6 5]'
x
y
z = [x;y]
cell_array = [cell_array;Computers]
speed = {'CPU Power',1.2,2.9,5.0}
cell_array
cell_array = [cell_array;speed]
rams = ['RAM',4,3,16]
rams = {'RAM',4,3,16}
cell_array = [cell_array;rams]
%%%CPUPOWER*RAM = AWESOMENESS
cell_array(3,2)*cell_array(4,2)
cell_array{3,2}*cell_array{4,2}
awesome1 = cell_array{3,2}*cell_array{4,2}
awesome2 = cell_array{3,3}*cell_array{4,3}
cell_array
awesome3 = cell_array{3,4}*cell_array{4,4}
Awesome = {'Awesome',awesome1,awesome2,awesome3}
cell_array = [cell_array;Awesome]
clear
clc
ls
edit MakeStructs.m
MakeStructs
students
MakeStructs
students
students(1)
students(2)
students(2).name
students(2).grades
students(1).grades
edit Compute_Grades.m
x = [3 4 5]
length(x)
length(1:10)
MakeStructs
avg
MakeStructs
students.Average
MakeStructs
students.Average
students(1).Average
students(2).Average
students
students(1)
students(2)
MakeStructs
clc
students
x = 1
disp(x)
disp('x')
str = 'x'
disp(str)
MakeStructs
clc
students
students.passfail
MakeStructs
students.passfail
clear
clc
5*4*3*2
edit fact
path
fact(5)
5*4*3*2
A= rand(5,5);
xlswrite('Test.xls',5);
xlswrite('Test.xls',A);
ls
edit Test.csv
[data,txt,all] = xlsread('Test.csv')
[data,txt,all] = csvread('Test.csv')
data = csvread('Test.csv')
edit Test.csv
data = csvread('Test.csv')
ls
[data,txt,all] = xlsread('Workbook1.xls')
whos
all{2:end,1}
all(2:end,1)
ls
whos
all
t = cell2struct(all)
help cell2struct
aircraft_data(1).Leg = 1
aircraft_data(2).Leg = 2
clear
aircraft_data.Leg = [1 2]
aircraft_data.Leg(1)
aircraft_data.Leg(2)
aircraft_data(1).Leg = 1
aircraft_data(2).Leg = 2
aircraft_data(2).Speed_mph = 200
aircraft_data(1).Speed_mph = 250
aircraft_data
aircraft_data.Leg
aircraft_data(1)