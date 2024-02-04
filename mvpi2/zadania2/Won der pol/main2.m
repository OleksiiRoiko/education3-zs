x0 = [0 1];
tspan = [0 50];
mu = 1;

[t,x] = ode45(@(t,x) unlin(t,x,mu),tspan,x0);

plot(t,x);
title('nonlinear system');
xlabel('t');
ylabel('x');
legend('x1','x2');
