function R = world_radius(t);

max_time = 0;
max_radius = 10;

if t>max_time
  %R = max_radius*(1-(t-max_time)/(30));
  R = max_radius*(1-0.01*(t-max_time));
  R = max_radius*(2-exp(0.004*(t-max_time)));
else
  R = max_radius*(1-0.01*(t-max_time));
  %R = max_radius;
end