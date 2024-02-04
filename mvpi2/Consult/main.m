syms theta dtheta g l m d u

f = [dtheta; -g/l*sin(theta) - d/m*dtheta + 1/m*u];

% State vector x = [theta; dtheta]
x = [theta; dtheta];

% Compute the Jacobian
B = jacobian(f, u);
disp(B);
B = simplify(B);
disp(B);
A = jacobian(f, x);
disp(A);

% Define system parameters
g_val = 9.81; % gravity
l_val = 0.6;    % length of the pendulum
m_val = 1;    % mass of the pendulum
d_val = 0.1;  % damping coefficient
u_val = 0.5;

% Evaluate A at the upright position (theta = 0, dtheta = 0)
A_linear = subs(A, {theta, dtheta, g, l, m, d, u}, {0, 0, g_val, l_val, m_val, d_val, u_val});
B_linear = subs(B, {theta, dtheta, g, l, m, d, u}, {0, 0, g_val, l_val, m_val, d_val, u_val});

% Linearized system matrices
A = double(A_linear);
B = double(B_linear);
C = eye(2);
D = [0; 0];
disp(A);
disp(B);

disp(eig(A));
% Define the Q and R matrices
Q = [1 0; 0 1];
R = 0.1;

% Calculate the LQR gain matrix K
K = lqr(A, B, Q, R);
disp(K);

out = sim("modelqr.slx");

figure;
hold on;
plot(out.simout.Time, out.simout.Data(:, 2), "lineWidth", 2);
plot(out.step.Time, out.step.Data, "lineWidth", 2);
hold off;
legend("Solution","Disorder");
xlabel("Time t");
ylabel("Solution y(t)");
title("Pendulum with LQR");


At = A - B * K;
t = 0:0.1:15;

[y,x] = step(At,B,C,D,1,t);

figure;
plot(t,x)
legend('x1','x2');