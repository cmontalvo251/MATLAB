clear
clc
close all

%%%Hockey Puck
t_vec = 0:0.1:10;
v0 = 11;
c = 1;
m = 2;
A = -c/m;
B = v0;
x_analytical_vec = exp(A*t_vec)*B;

plot(t_vec,x_analytical_vec)

%%%%Second Order System
t_vec = 0:0.1:10;
z0 = [5;0];
k = 100;
c = 2;
m = 3;
A = [0 1;-k/m -c/m];
B = z0;
x_analytical_vec = zeros(2,length(t_vec));
x_eigen_vec = zeros(2,length(t_vec));
[V,L] = eig(A);
for idx = 1:length(t_vec)
    x_analytical_vec(:,idx) = expm(A*t_vec(idx))*B;
    x_eigen_vec(:,idx) = V*expm(L*t_vec(idx))*inv(V)*z0;
end

figure
plot(t_vec,x_analytical_vec)
figure
plot(t_vec,x_eigen_vec)

%%%%Pendulum Order System
t_vec = 0:0.1:10;
z0 = [60*pi/180;0];
g = 9.81;
L = 20;
c = 0.4;
A = [0 1;-g/L -c];
B = z0;
x_analytical_vec = zeros(2,length(t_vec));
x_eigen_vec = zeros(2,length(t_vec));
[V,L] = eig(A);
for idx = 1:length(t_vec)
    x_analytical_vec(:,idx) = expm(A*t_vec(idx))*B;
    x_eigen_vec(:,idx) = V*expm(L*t_vec(idx))*inv(V)*z0;
end

figure
plot(t_vec,x_analytical_vec)
figure
plot(t_vec,x_eigen_vec)


%%%%Fourth Order System
t_vec = 0:0.1:100;
z0 = [5;0;0;0];
c1 = 100;
c2 = 2;
c3 = 7;
c4 = 25;
A = [0 1 0 0;0 0 1 0;0 0 0 1;-c4 -c3 -c2 -c1];
B = z0;
x_analytical_vec = zeros(4,length(t_vec));
x_eigen_vec = zeros(4,length(t_vec));
[V,L] = eig(A);
for idx = 1:length(t_vec)
    x_analytical_vec(:,idx) = expm(A*t_vec(idx))*B;
    x_eigen_vec(:,idx) = V*expm(L*t_vec(idx))*inv(V)*z0;
end

figure
plot(t_vec,x_analytical_vec)
figure
plot(t_vec,x_eigen_vec)


