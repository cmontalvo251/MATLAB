clear
clc
close all

Average_Max_Temperature_F = [	57.8	62.2	68.4	76.0	84.3	88.2	90.7	90.7	86.9	79.5	68.0	60.5];
Average_Min_Temperature_F =	[ 39.2	43.7	50.6	59.1	67.2	72.0	74.0	74.1	70.0	59.2	49.4	42.2];
Average_Total_Precipitation_in = [ 6.06	5.56	4.50	5.79	3.28	6.68	6.80	5.19	4.55	3.19	3.15	5.97];
months = 1:12;


fig = figure();
set(fig,'color','white')
plot(months,Average_Min_Temperature_F,'b*')
grid on
hold on
plot(months,Average_Max_Temperature_F,'g*')
xlabel('Month')
ylabel('Average Min Temperature(F)')


%%%% Y = HA

Y = Average_Min_Temperature_F';
X = months';

H = [];
N = 6;
for idx = 0:N
    H = [H,X.^idx];
end

Astar = inv(H'*H)*H'*Y;

Ytilde = H*Astar;

R = sum((Y-Ytilde).^2)

plot(X,Ytilde,'r-','LineWidth',2)



