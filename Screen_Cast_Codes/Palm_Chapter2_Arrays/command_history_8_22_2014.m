%-- 8/22/2014 9:04 AM --%
ls
exist
x= 1
y = 2
z = x*y
who
whos
exist('x','var')
exist('y','var')
exist('p','var')
exist('p','var')*15
exist('x','var')*15
exist('y','var')*15
who
y
clear y
who
exist('y','var')*15
y
y = 2
y*15
edit
class2
disp('Hello world')
whos
y
ystr = num2str(y)
y
ystr
whos
ystr+ 2
y + 2
str2num('4.2')
whos
str2num('h')
whos
str2num('4/2')
x = 42
disp('x = 2')
disp(['x = ',num2str(x)])
x = 32
disp(['x = ',num2str(x)])
ls
class2
cd ../
class2
cd ../
cd Do
cd Documents\
cd MATLAB\
ls
mkdir Test_Dir
cd Test_Dir\
ls
class2
clear
class2
ls
path
C:\Users\student\Documents\MATLAB
cd ../../
ls
cd ../Desktop/
ls
edit class2_Desktop.m
class2_Desktop
cd ../Documents/MATLAB/
ls
class2_Desktop
path
addpath 'C:\Users\student\Desktop'
class2_Desktop
clear
clc
who
x = 1
whos
str = 'hello'
whos
vec = [12 34 54 42]
whos
vec = -10:1:10
vec = 0:0.1:2.01
vec = 0:0.1:2.09
vec = 0:0.1:2.1
whos
x = [32; 43; 45]
whos
x = linspace(-10,10,5)
x = linspace(-10,10,9)
x = 3:3:100
x = 3:3:100;
y = -1000:0.0001:1000;
whos
y = -1000:0.0001:1000
ls
x
x = [1 2 3]
x = [1 2 3]'
A = [ 1 2 3 ; 4 5 6 ; 7 8 9]
whos
A*x
A'*x
A'
A
x = 2
y = 2
x + y
x- y
A + A
A - A
A = [3 5 6;2 8 -4;1 -16 3]
b = [10 -5 1]'
A*inv(A)
v = x
v = inv(A)*b
x = v(1)
y = v(2)
z = v(3)
3*x + 5*y + 6*z
A*v
A
A/A
water_bottle_ml = [12 34 56]
water_bottle_L = water_bottle_ml/1000
drive_time_sec = [23 45 21]
cars_m = [1000 1 100000]
drive_time_sec
cars_m
cars_m./drive_time_sec
cars_m/cars_m
cars_m./cars_m
A
A/A
A./A
x = [ 2 3 4 5]
x^2
x = 2
x^2
x = [ 1 2 3 4]
x^2
x.^2
x_vec = [1 2 3 4]
x = 2
x = [2 3 4 5]
x_dbl = 2
x_vec_dbl = [ 2 3 4 5]
x_vec_dbl.^2
A
A'
A*A
A'*A
row1 = [ 1 2 3]
row2 = [4 5 6]
row3 = [7 8 9]
A = [row1;row2;row3]
A'
A,
A(2,2)
A(2,1:2)
A(2,:)
A(:,2)
A
A(1)
A(2)
A(3)
A(3,1)
A(1,3)
whos
8*9
A = [ 1 2 3 ;4 5 6 ;7 8 9 ]
row1 = [1 2 3]
c = [row1;row1]
c = zeros(2,3)
c(1,:) = row1
c(2,:) = row2
help roots
roots([1 0 -1])
roots([1 4 1 -3 0 0])
x = -5:0.1:5;
x
y = x.^5 + 4*x.^4 + x.^3 - 3*x.^2;
y
plot(x,y)
ylim([-1 1])
roots([1 4 1 -3 0 0])
class2_Desktop
clear
clc
who
class2_Desktop
ls
disp('Now I can see')
A
clear
clc