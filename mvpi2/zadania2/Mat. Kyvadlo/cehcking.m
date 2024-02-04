l = 2; % Length of the pendulum
g = 9.8; % Acceleration due to gravity

syms theta omega real

tspan = [0 10];

f = [omega; -(g/l*sin(theta))];

J = jacobian(f, [theta, omega]);


J_stable = double(subs(J, [theta, omega], [0, 0]));
J_unstable = double(subs(J, [theta, omega], [3*pi, 0]));

x0 = [pi/2; 0]; % Small displacement from theta = 0

[t_nl, x_nl] = ode45(@(t, x) pendulum(t, x, l, g), tspan, x0);

f_linear_stable = @(t, x) J_stable * x;

[t_l, x_l] = ode45(f_linear_stable, tspan, x0);

figure;
plot(t_nl, x_nl, 'b', t_l, x_l, 'r--');
legend('Nonlinear System', 'Linearized System');
title('Comparison of Nonlinear and Linearized System at Stable Equilibrium');
xlabel('Time (s)');
ylabel('Theta (rad)');

x0_unstable = [pi + 3; 3]; % Small displacement from theta = pi

[t_nl_unstable, x_nl_unstable] = ode45(@(t, x) pendulum(t, x, l, g), tspan, x0_unstable);

f_linear_unstable = @(t, x) J_unstable * x;

[t_l_unstable, x_l_unstable] = ode45(f_linear_unstable, tspan, x0_unstable);

figure;
plot(t_nl_unstable, x_nl_unstable, 'b', t_l_unstable, x_l_unstable, 'r--');
legend('Nonlinear System', 'Linearized System');
title('Comparison of Nonlinear and Linearized System at Unstable Equilibrium');
xlabel('Time (s)');
ylabel('Theta (rad)');

disp('Jacobian at stable equilibrium (theta = 0):');
disp(J_stable);

disp('Jacobian at unstable equilibrium (theta = pi):');
disp(J_unstable);

eig_stable = eig(J_stable);
eig_unstable = eig(J_unstable);

disp('Eigenvalues at stable equilibrium (theta = 0):');
disp(eig_stable);

disp('Eigenvalues at unstable equilibrium (theta = pi):');
disp(eig_unstable);
