function draw_plus_sign(state,wingspan)

cg = state(1:3);
phi = state(4);
theta = state(5);
psi = state(6);

frontB = [wingspan/2;0;0];
backB = -frontB;
leftB = -[0;wingspan/2;0];
rightB = -leftB;

%%%%Create Rotation Matrix
R = R123(phi,theta,psi);

%%%%Rotate front back left and right
frontI = R*frontB;
backI = R*backB;
leftI = R*leftB;
rightI = R*rightB;

%%%%Move by cgp
front = frontI + cg;
back = backI + cg;
left = leftI + cg;
right = rightI + cg;

%%%%Plot legs
hold on
plot3([cg(1) front(1)],[cg(2) front(2)],[cg(3) front(3)],'y-','LineWidth',2);
plot3([cg(1) back(1)],[cg(2) back(2)],[cg(3) back(3)],'y-','LineWidth',2);
plot3([cg(1) left(1)],[cg(2) left(2)],[cg(3) left(3)],'k-','LineWidth',4);
plot3([cg(1) right(1)],[cg(2) right(2)],[cg(3) right(3)],'k-','LineWidth',4);


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
