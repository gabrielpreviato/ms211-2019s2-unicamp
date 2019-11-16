#
# MS211 Projeto 5
# Authors: Gabriel Previato RA172388
#          Pedro Souza      RA223515
#

x(1, :) = [0, -14, -18, -26, -31];
velocity(1, :) = [0, 0, 0, 0, 0];

# Max velocity in m/s
max_vel = 50/3.6;
delta_s = 42;

# Sensibility defined as 1s^(-1)
sensibility = 1;

# Function to calculate the
# bus position
function ret=bus_pos(time_)
  ret = 8 * time_ - 90 * sin(0.1 * time_);
endfunction

# Function to calculate the
# bus velocity (derivative of bus_pos)
function ret=bus_vel(time_)
  ret = 8 - 9 * cos(0.1 * time_);
endfunction

# We first calculate the position and velocity
# of the bus for every instant of time between (1s and 301s)
for i = 2:301
  x(i,1) = bus_pos(i);
  velocity(i,1) = bus_vel(i);
endfor

# Now we calculate the distance between all vehicles
for i = 1:4
  delta_x(i + 1) = x(1, i) - x(1, i+1);
endfor

# Otimum velocity model
vel = (max_vel/2) * (tanh((delta_x - delta_s)/20) + tanh(4));

# For every instant of time between (0s and 300s)
for t = 1:300
  # For all cars
  for i = 2:5
    x(t+1,i) = x(t,i) + sensibility * vel(1,i);
    velocity(t + 1, i) = velocity(t, i) + sensibility * (vel(1, i) - velocity(t, i));
  endfor

  # For all vehicles
  for i = 1:4
    delta_x(1) = 0;
    delta_x(i+1) = x(t,i) - x(t,i+1);
  endfor

  # Otimum velocity model
  vel = (max_vel/2) * (tanh((delta_x - delta_s)/20) + tanh(4));  
endfor

# Finaly, let's plot our results
plot(x(:,:))
ylabel("Position")
xlabel("Time")
legend("Bus", "Car 1", "Car 2", "Car 3", "Car 4")
