%%%MAke a circle
purge

theta = 0:0.001:(180/pi);


x = cos(theta);
y = sin(theta);

figure()
plot(x,y)

figure()
plot(x)

figure()
plot(y)


tan2 = atan2(y,x);
tan = atan(y./x);

tanfun = arcfun(y,x);

figure()
plot(theta,tan2)
hold on
plot(theta,tan,'r-')
plot(theta,tanfun,'g-')

legend('Atan2','Atan','TanFun')

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
