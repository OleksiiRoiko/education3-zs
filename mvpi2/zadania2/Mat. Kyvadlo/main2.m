x0 = [7 7];
tspan = [0 10];
l = 2; % Length of the pendulum
g = 9.8; % Acceleration due to gravity
m = 0.3038; % Mass of the pendulum bob
B = 0.5; % Damping coefficient adjusted for damping
MM = 0; % No external driving torque


[t,x] = ode45(@(t,x) pendulum(t,x,m,l,B,g,MM),tspan,x0);

plot(t,x(:,1));