% Ваш файл main.m
% par_stable_node = [-2 0; 0 -3]; %jordan
% par_unstable_node = [2 0; 0 3];%jordan
% par_saddle = [2 0; 0 -2];%jordan
% par_center = [0 1; -1 0];%jacobian
% par_spiral_stable = [-1 -1; 1 -1];%jacobian 
% par_spiral_unstable = [1 1; -1 1];%jacobian 

tspan = [0 10];

% figure;
% 
% for i = -10:2:10
%     for j = -10:2:10
%         x0 = [i j];
%         [t, x] = ode45(@(t,x) lin(t,x,par_stable_node), tspan, x0);
%         %plot(x(:,1), x(:,2),'r');
%         %plot(t,x(:,2),'g')
%         hold on;
%     end
% end

[t, x] = ode45(@fun, tspan, [0 1]);
plot(t,x)
title('Solution');
xlabel('t');
ylabel('x');
% [x1, x2] = meshgrid(-20:2:20, -20:2:20);
% x1dot = par_saddle(1,1) .* x1 + par_saddle(1,2) .* x2;
% x2dot = par_saddle(2,1) .* x1 + par_saddle(2,2) .* x2;
% quiver(x1, x2, x1dot, x2dot, 1.2,'g');
% xlim([-20,20])
% ylim([-20,20])


