function x_roots = PolyFun(coeff)
%%%%This function will do some cool stuff with Polynomials
%%The input coeff is a vector of polynomials
%%%PolyFun(coeff)

close all %%This will close all Figures

%%%Plot this function
x = linspace(-10,10,100);
%x = -10:0.1:10;
y = polyval(coeff,x);

%%Make a figure and make it look pretty
fig = figure('Name','XYPlot'); %%Opens the figure window
set(fig,'color','white'); %%%Sets the background of the figure to white
set(axes,'FontSize',16)

%%%Plot the x and y variables
%plot(x,y,'rs--','LineWidth',3,'MarkerSize',10); %%%This plots a red dashed line with squares with a width of 3 and a markersize of 10
plot(x,y,'r--','LineWidth',3,'MarkerSize',10); %%%This plots a red dashed line with a width of 3 and a markersize of 10
xlabel('X (m)','FontSize',16)
ylabel('Y (m)','FontSize',16)
title('XY Plot Example')

%%Create a grid
grid on 

%%%Plot the roots
x_roots = roots(coeff);


%%%%Hold the figure
hold on

%%%%I want to compute the imaginary component of my roots
im = imag(x_roots);
%%%Where are my real roots? Tell me the location of where the imaginary
%%%component is equal to zero
%%%To do that we need a logical test
bool_1_or_0 = (im == 0)

%%%Find it
location = find(im == 0);

%%%Now that I have the indices
real_roots = x_roots(location);

num_real_roots = length(real_roots);
y_roots = zeros(num_real_roots,1);

plot(real_roots,y_roots,'bo','MarkerSize',10)

%real_roots = x_roots(location);
%location = find(im == 0)
%real_roots = x_roots(find(im == 0));
%im = imag(x_roots)
%real_roots = x_roots(find(imag(x_roots) == 0));
