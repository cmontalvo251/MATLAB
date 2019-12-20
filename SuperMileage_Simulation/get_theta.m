function theta= get_theta(xcar)

x_track = [0.00 347.47 694.61 1041.83 1488.07 1885.37 2620.62 3322.20 3921.10 4318.48 4863.75 5359.54 5855.33 6103.85 6153.79 6203.62 6253.48 6303.45 6353.56 6403.64 7053.49 7715.67 8433.37];
x_track= x_track*0.3048; %X Position ft to m conversion

z_track = [939.10 938.68 938.16 937.55 936.70 935.67 935.01 935.50 941.40 945.57 950.75 955.49 960.15 957.44 954.43 950.86 947.08 943.55 940.69 939.64 939.25 939.46 939.10];
z_track= (z_track-935.01)*0.3048; %X Position ft to m conversion

delx = 0.1;
xU = xcar + delx;
zU = interp1(x_track,z_track,xU);

xL = xcar;
zL = interp1(x_track,z_track,xL);

theta= -atan2(zU-zL,xU-xL);



