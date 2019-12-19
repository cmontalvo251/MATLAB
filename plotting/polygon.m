function polygon(N)
%%%This will draw a polygon on the screen for you
close all
hold on
%%%Initialize the drawer
x = 0;
y = 0;
%%%Compute the interior_angle
interior_angle = (N-2)*180/N
total_angle = (N-2)*180
sum_angle = 0;
for idx = 1:N
    %%%%Compute next point
    x1 = x + 1*cosd(sum_angle);
    y1 = y + 1*sind(sum_angle);
    %%%Draw the line
    plot([x x1],[y y1],'b-')
    %%%Step the pointer
    x = x1;
    y = y1;
    sum_angle = sum_angle + (180-interior_angle);
end
axis equal

