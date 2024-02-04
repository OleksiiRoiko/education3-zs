% Define the parameters for the pendulum
l = 2; % Length of the pendulum
g = 9.8; % Acceleration due to gravity

tspan = [0 10];

figure;

% Define symbols for the variables
syms theta omega real

% Define the system of equations
f = [omega; -(g/l)*sin(theta)];

% Calculate the Jacobian matrix
J = jacobian(f, [theta, omega]);

% Evaluate the Jacobian matrix at the first equilibrium point (0, 0)
J_at_equilibrium1 = double(subs(J, [theta,omega], [0, 0]));

% Evaluate the Jacobian matrix at the second equilibrium point (pi, 0)
J_at_equilibrium2 = double(subs(J, [theta,omega], [pi, 0]));

% Define the linearized system of differential equations for the first equilibrium
f_linear1 = @(t, Y) J_at_equilibrium1 * Y;

% Define the linearized system of differential equations for the second equilibrium
f_linear2 = @(t, Y) J_at_equilibrium2 * Y;


% x0 = [7 7];
% [t, x] = ode45(f_linear1, tspan, x0);
% plot(t, x,'r');
%Plot the phase portrait for the first equilibrium point
for i = linspace(-10, 10, 10)
    for j = linspace(-10, 10, 10)
        x0 = [i; j];
        [t, x] = ode45(f_linear1, tspan, x0);
        plot(x(:,1), x(:,2), 'r', 'LineWidth', 0.5);
        hold on;
        [t1, x1] = ode45(f_linear2, tspan, x0);
        plot(x1(:,1), x1(:,2), 'b', 'LineWidth', 0.5);
        hold on
    end
end


% Set the title and labels for the plot
title('Phase Portrait of Linearized Mathematical Pendulum');
xlabel('x');
ylabel('y');

% Create the vector field for the first equilibrium point
[X, Y] = meshgrid(-10:10, -10:10);
U1 = J_at_equilibrium1(1,1)*X + J_at_equilibrium1(1,2)*Y;
V1 = J_at_equilibrium1(2,1)*X + J_at_equilibrium1(2,2)*Y;

% Create the vector field for the second equilibrium point
U2 = J_at_equilibrium2(1,1)*X + J_at_equilibrium2(1,2)*Y;
V2 = J_at_equilibrium2(2,1)*X + J_at_equilibrium2(2,2)*Y;

% Plot the vector fields
quiver(X, Y, U1, V1, 1.7, 'r');
quiver(X, Y, U2, V2, 1.7, 'b');

% Set the limits for the axes
xlim([-10, 10]);
ylim([-10, 10]);
