% Define the parameters for the pendulum
mu = 1;

% Define the symbols for the variables and parameter
syms u1 u2 real

% Time span for the simulation
tspan = [0 10];

% Initial conditions close to the stable equilibrium point
x0 = [0 1]; 

% Simulate the nonlinear system
[t_nl, x_nl] = ode45(@(t, x) unlin(t, x, mu), tspan, x0);


% Define the linearized system at the stable equilibrium point
A_stable = [0, 1; -1, 1];
f_linear_stable = @(t, x) A_stable * x;

% Simulate the linearized system
[t_l, x_l] = ode45(f_linear_stable, tspan, x0);

% Plot the results
figure;
hold on
plot(t_nl, x_nl, 'b');
plot(t_l, x_l, 'r--');
hold off
legend('Nonlinear System(1)','Nonlinear System(2)', 'Linearized System(1)','Linearized System(2)');
title('Comparison of Nonlinear and Linearized System at Stable Equilibrium');
xlabel('Time (s)');
ylabel('x');


% Define the system of equations
f = [u2; mu*(1 - u1.^2).*u2 - u1];

% Compute the Jacobian matrix
J = jacobian(f, [u1, u2]);
disp('Jacobian');
disp(J);

% Evaluate the Jacobian matrix at the equilibrium points
J_stable = double(subs(J, [u1, u2], [0, 0]));

% Display the evaluated Jacobian matrices
disp('Jacobian at stable equilibrium (u1 = 0):');
disp(J_stable);

% Check eigenvalues of each Jacobian to determine the type of equilibrium
eig_stable = eig(J_stable);

disp('Eigenvalues at stable equilibrium (u1 = 0):');
disp(eig_stable);


