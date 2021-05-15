## Copyright (C) 2016 cmontalvo
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} plotstuff (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: cmontalvo <cmontalvo@CARLOS>
## Created: 2016-02-03

clear
clc
close all

system('g++ -o Run.exe brandon.cpp');
system('Run.exe');

data =dlmread('Simulation2Results.txt');

time = data(:,1);
x = data(:,2);
y = data(:,3);
z = data(:,4);
u = data(:,5);
v = data(:,6);
w = data(:,7);

fig = figure();
set(fig,'color','white');
plot(time,u,'b-','LineWidth',4)
hold on
plot(time,v,'r-','LineWidth',2)
plot(time,w,'g-','LineWidth',2)
set(gca,'FontSize',18)
xlabel('Time (sec)')
ylabel('Velocity (m/s)')
legend('u','v','w')
grid on

fig = figure();
set(fig,'color','white');
plot(time,z,'b-','LineWidth',2)
set(gca,'FontSize',18)
xlabel('time (s)')
ylabel('z (m)')
grid on

fig = figure();
set(fig,'color','white');
plot3(x,y,z)
xlabel('x');ylabel('y');zlabel('z');