xdot_car = 10*3600/5280;
Lcar = 4.47; %m
h = 1.83; %m
width = 2; %meters
m = 5200/2.2; %%kg
k = 100000; %%N/m
c = 5000; %%N-s/m
ct = 1000;
g = 9.81; %%m/s^2
Izz = (m/12)*(Lcar^2 + width^2);
Ixx = (m/12)*(h^2+width^2);
Iyy = (m/12)*(Lcar^2 + h^2);
I = [Ixx 0 0;0 Iyy 0 ; 0 0 Izz];
mt = 2000/2.2; %%kg 
Lt = 4.47;
ht = 0.9;
Izz_trailer = (mt/12)*(Lt^2+h^2);
kp = 10*m/xdot_car;
kpslide = -1*m;
kpturn = -50*Izz;
kdturn = -20*Izz;

%%%Distance from Cg to Hitch in Body Frame
rcg_Hitch = [-2.24;0;0];
rH_trailer = [-2.21;0;-0.0438];
%%%Distance from CG to tires
rcg_Tire1 = [1.5694;0.854;0.6350];
rcg_Tire2 = [1.5694;-0.854;0.6350];
rcg_Tire3 = [-1.43806;0.854;0.6350];
rcg_Tire4 = [-1.43806;-0.854;0.6350];

rcg_Tire = [rcg_Tire1,rcg_Tire2,rcg_Tire3,rcg_Tire4];

%%%Distance from Trailer CG to tires
rcgTrailerTires = [-0.73377 -0.73377;1.21775 -1.21775;0.4468 0.4468];

