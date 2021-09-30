close all
clear
clc
%%This script will determine the diameter of the cross section, the unknown
%%nodal displacements, the unknown reaction force, and the axial stress in
%%each bar member. This will be determined from the input of the
%%coordinates of the nodes along with the forces acting on the truss. 

%%This is where I will define the area, the Young's Modulus, and the
%%ultimate yeild stress. 
d = 0.017263812316122;%%Meters
a = d^2;
E = 69*10^9; %%Pa
uys = .255*10^9; %%Pa
%%A factor of safety of 4 will be used in this design. 
FS = 4;
%%This is where I define the global x,y coordinates for the nodes.
n1 = [-0.5,1];
n2 = [0,0];
n3 = [0.5,1];
n4 = [1,0];
n5 = [1.5,1];

%%This is the columns and rows of the structural stiffness matrix that each
%%node will occupy.
node1 = [1 2];
node2 = [3 4];
node3 = [5 6];
node4 = [7 8];
node5 = [9 10];

%%This is where I define the start and end node for each element and
%%calculate the length. 

ele1 = [n1,n2];
l1 = (((ele1(2)-ele1(4))^2)+((ele1(3)-ele1(1))^2))^0.5;
ele2 = [n1,n3];
l2 = (((ele2(2)-ele2(4))^2)+((ele2(3)-ele2(1))^2))^0.5;
ele3 = [n2,n3];
l3 = (((ele3(2)-ele3(4))^2)+((ele3(3)-ele3(1))^2))^0.5;
ele4 = [n2,n4];
l4 = (((ele4(2)-ele4(4))^2)+((ele4(3)-ele4(1))^2))^0.5;
ele5 = [n3,n4];
l5 = (((ele5(2)-ele5(4))^2)+((ele5(3)-ele5(1))^2))^0.5;
ele6 = [n3,n5];
l6 = (((ele6(2)-ele6(4))^2)+((ele6(3)-ele6(1))^2))^0.5;
ele7 = [n4,n5];
l7 = (((ele7(2)-ele7(4))^2)+((ele7(3)-ele7(1))^2))^0.5;

%%This is where I will begin to determine the c, s, and cs to begin
%%constructing the element stiffness matrices.

c = (ele1(3)-ele1(1))/l1;
s = (ele1(4)-ele1(2))/l1;
K1 = (a*E/l1)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K1all = zeros(10,10);
r = [node1 node2];
K1all(r,r) = K1;

c = (ele2(3)-ele2(1))/l2;
s = (ele2(4)-ele2(2))/l2;
K2 = (a*E/l2)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K2all = zeros(10,10);
r = [node1 node3];
K2all(r,r) = K2;

c = (ele3(3)-ele3(1))/l3;
s = (ele3(4)-ele3(2))/l3;
K3 = (a*E/l3)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K3all = zeros(10,10);
r = [node2 node3];
K3all(r,r) = K3;

c = (ele4(3)-ele4(1))/l4;
s = (ele4(4)-ele4(2))/l4;
K4 = (a*E/l4)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K4all = zeros(10,10);
r = [node2 node4];
K4all(r,r) = K4;

c = (ele5(3)-ele5(1))/l5;
s = (ele5(4)-ele5(2))/l5;
K5 = (a*E/l5)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K5all = zeros(10,10);
r = [node3 node4];
K5all(r,r) = K5;

c = (ele6(3)-ele6(1))/l6;
s = (ele6(4)-ele6(2))/l6;
K6 = (a*E/l6)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K6all = zeros(10,10);
r = [node3 node5];
K6all(r,r) = K6;

c = (ele7(3)-ele7(1))/l7;
s = (ele7(4)-ele7(2))/l7;
K7 = (a*E/l7)*[c^2 c*s -(c^2) -c*s;c*s s^2 -c*s -(s^2)...
    ;-(c^2) -c*s c^2 c*s;-c*s -(s^2) c*s s^2];
K7all = zeros(10,10);
r = [node4 node5];
K7all(r,r) = K7;

%%This is the sumation of all the element stiffness matricies into a
%%structure stiffness matrix.
K = K1all + K2all + K3all + K4all + K5all + K6all + K7all;

%%This is looking at only rows and columns 5-10 in order to solve for the
%%diaplacements. 
matx = K([5 6 7 8 9 10],[5 6 7 8 9 10]);
matx(:,7) = [0 0 0 0 4000 -10000];
smatx = rref(matx);

%%This is the amount of deflection at each node in each direction. 
dx1 = 0;
dy1 = 0;
dx2 = 0;
dy2 = 0;
dx3 = smatx(1,7);
dy3 = smatx(2,7);
dx4 = smatx(3,7); 
dy4 = smatx(4,7);
dx5 = smatx(5,7);
dy5 = smatx(6,7);

x = [dx1 dy1 dx2 dy2 dx3 dy3 dx4 dy4 dx5 dy5]';
%%This is the calculation of reaction forced using Hooke's Law, F = kx
R = K*x;
Rx1 = R(1);
Ry1 = R(2);
Rx2 = R(3);
Ry2 = R(4);

%%The internal forced will be defined as I1, I2, ect.. Where I denotes
%%an internal force and the number denotes the element. 
%%A1 and A2 are the angles found in this strucutre. 
A1 = atan(1/0.5);%%Approximatley 63.435 degrees
A2 = atan(0.5/1);%%Approximatley 26.565 degrees
I1 = 0;
I2 = (abs(Rx1));
I3 = (-abs(Ry2))/cos(A2);
I4 = abs(Rx2)+(I3*cos(A1));
I5 = -I3;
I6 = I2-I5*cos(A1)+I3*cos(A1);
I7 = -I5;
%%To check the calculations the forces acting on the structure will be
%%calculated and compared to the vlaues stated in the problem. The forces
%%will be called Fx and Fy.
Fx = I6+I7*cos(A1);
Fy = I7*sin(A1);
%%The applied forces match the calculated forces therefore the calculations
%%are correct. 

I = [I1 I2 I3 I4 I5 I6 I7]';
MI = max(I);
%%The internal stress will now be calculated from the maximum internal
%%force and will then be compared to the allowed yeild stress. 

%%The factor of safety will be multiplied by the internal force in this
%%calculation

IntStr = FS*MI/a;%%Units will come out as Pascals






