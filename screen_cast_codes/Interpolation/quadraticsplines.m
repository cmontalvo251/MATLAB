clear
clc
close all
X = (-10:10)';
Y = sin(5*X);% + rand(length(X),1);

fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
p0 = plot(X,Y,'b*','MarkerSize',10);
xlabel('X')
ylabel('Y')
grid on
hold on

%%%Linear Splines
for idx = 1:length(X)-1
   m = (Y(idx+1)-Y(idx) )/(X(idx+1)-X(idx));
   xspline = linspace(X(idx),X(idx+1),10);
   yspline = m*(xspline-X(idx)) + Y(idx);
   p1 = plot(xspline,yspline,'g-','LineWidth',2);
end

%%%Quadratic Splines
N = length(X);
n = N-1;

%%%%Create H0 = [2*(n-1) x 3*n]
H0 = zeros(2*n-2,3*n);
K0 = zeros(2*n-2,1);
for idx = 1:(n-1)
    col = idx;
    row = 2*(idx-1)+1;
    H0(row,col) = X(idx+1)^2;
    H0(row+1,col+1) = X(idx+1)^2;
    H0(row,n+col) = X(idx+1);
    H0(row+1,n+col+1) = X(idx+1);
    H0(row,2*n+col) = 1;
    H0(row+1,2*n+col+1) = 1;
    K0(row) = Y(idx+1);
    K0(row+1) = Y(idx+1);
end

%%%Create H1 = [n-1 x 3*n];
H1 = zeros(n-1,3*n);
for idx = 1:n-1
    H1(idx,idx) = 2*X(idx+1);
    H1(idx,idx+1) = -2*X(idx+1);
    H1(idx,n+idx) = 1;
    H1(idx,n+idx+1) = -1;
end
%%%Create HE
HE = zeros(2,3*n);
HE(1,1) = X(1)^2;
HE(1,n+1) = X(1);
HE(1,2*n+1) = 1;
HE(2,n) = X(end)^2;
HE(2,2*n) = X(end);
HE(2,end) = 1;

%%%Compute H
H = [H0;H1;HE];
[r,c] = size(H);

%%%Compute K
K = zeros(r,1);
K(1:(2*(n-1))) = K0;
K(end-1) = Y(1);
K(end) = Y(end);

%%%Assume now that a1 = 0
H = H(:,2:end);

coeffs = inv(H)*K;

%%%Get all your A's,B's, and C's
A = [0;coeffs(1:n-1)];
B = coeffs(n:2*n-1);
C = coeffs(2*n:end);

%%%%Plot the results
for idx = 1:n
    xspline = linspace(X(idx),X(idx+1),10);
    yspline = A(idx)*xspline.^2 + B(idx)*xspline + C(idx);
    p2 = plot(xspline,yspline,'r-','LineWidth',2);
end

legend([p0 p1 p2],'Measured Data','Linear Spline','Quadratic Spline')





