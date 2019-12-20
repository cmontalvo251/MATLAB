xcar = StateOUT(1,:);
ucar = StateOUT(2,:);
throttle = StateOUT(3,:);
throttle_command = ControlOUT(1,:);
FinishLoc = find(xcar > xFinish,1);
FinishTime = time(FinishLoc);

plottool(1,'Mountain',14,'X (m)','AGL (m)');
plot(xmountain,zmountain,'b-','LineWidth',2)
axis equal
    
theta_mountain = get_theta(xmountain,zmountain,xmountain);
    
plottool(1,'Theta',14,'Time (sec)','\theta (deg)');
plot(xmountain,theta_mountain*180/pi,'b-','LineWidth',2)

plottool(1,'X',14,'Time (sec)','X Position (m)');
plot(time,xcar)
plot([FinishTime FinishTime],[min(xcar) max(xcar)],'g-')

plottool(1,'U',14,'Time (sec)','Forward Velocity (m/s)');
plot(time,ucar)
plot(time,VL*(0*xcar+1),'r-')
plot([FinishTime FinishTime],[min(ucar) max(ucar)],'g-');

plottool(1,'Throttle',14,'Time (sec)','Throttle (%)');
plot(time,throttle)
plot(time,throttle_command,'r-')
if exist('throttle_time','var')
    plot(throttle_time,throttles,'r*')
end
legend('Throttle Position','Command','Optimization Nodes')
plot([FinishTime FinishTime],[0 100],'g-')
ylim([0 100])

plottool(1,'Fuel Burn',14,'Time (sec)','Fuel Burn gal/s');
fuel_burn = ComputeBurn(StateOUT,throttle);
plot(time,fuel_burn)
plot([FinishTime FinishTime],[min(fuel_burn) max(fuel_burn)],'g-')
disp(['Total Fuel Burn = ',num2str(sum(fuel_burn(1:FinishLoc))*timestep),' gallons'])