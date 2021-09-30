function [t_out, botarray_out] = next_step(t,dt,botarray)
% Returns the next game state
% RK4 integration with timestep dt

x = botarray2state(botarray);

xdot1 = total_derivative( t, state2botarray(x,botarray));
xdot2 = total_derivative( t+dt/2, state2botarray(x + xdot1*dt/2,botarray) );
xdot3 = total_derivative( t+dt/2, state2botarray(x + xdot2*dt/2,botarray) );
xdot4 = total_derivative( t+dt, state2botarray(x + xdot3*dt,botarray) );

xdot = 1/6*(xdot1 + 2*xdot2 + 2*xdot3 + xdot4);

x = x + xdot*dt;
t_out = t + dt;

botarray_out = state2botarray(x,botarray);