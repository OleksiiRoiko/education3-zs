% Parameters
l = 2; % Length of the pendulum
g = 9.8; % Acceleration due to gravity

tspan = [0 10]; % Time span for the simulation

figure; % Create a new figure

% Use a much denser grid for initial conditions to capture more details
for i = linspace(-10, 10, 10) % Increased density of initial angles
    for j = linspace(-10, 10, 10) % Increased density of initial angular velocities
        x0 = [i j]; % Initial conditions [theta, omega]
        [t, x] = ode45(@(t,x) pendulum(t,x,l,g), tspan, x0);
        plot(x(:,1), x(:,2), 'r', 'LineWidth', 0.5); % Red trajectories with thinner lines
        hold on;
    end
end

% Set the title and labels for the plot
title('Phase Portrait of the mathematical pendulum');
xlabel('Angle (rad)');
ylabel('Angular velocity (rad/s)');

% Create a denser grid for the vector field
[X, Y] = meshgrid(linspace(-10, 10, 10), linspace(-10, 10, 10)); 
U = Y; 
V = -(g/l)*sin(X); % Adjusted for damping

% Create a denser quiver plot for the vector field
quiver(X, Y, U, V, 'b', 'LineWidth', 1);

% Set the limits for the axes
xlim([-10, 10])
ylim([-10, 10]);


