% Ваш файл main.m
mu = 0.8; % Define the parameter for the Van der Pol oscillator

tspan = [0 10];

figure;

for i = -5:1:5
    for j = -5:1:5
        x0 = [i j];
        [t, x] = ode45(@(t,x) unlin(t,x,mu), tspan, x0);
        plot(x(:,1), x(:,2),'r');
        hold on;
    end
end

title('Phase Portrait of the Van der Pol Oscillator');
xlabel('x');
ylabel('y');
[X, Y] = meshgrid(-10:10, -10:10);
U = Y; 
V = mu*(1 - (X.^2)).*Y - X;
% Create a mask for the center of the phase portrait
centerMask = (abs(X) < 3) & (abs(Y) < 3);

% Calculate U and V for the center
U_center = U .* centerMask;
V_center = V .* centerMask;

% Calculate U and V for the rest of the plot
U_rest = U .* ~centerMask;
V_rest = V .* ~centerMask;

% Create the quiver plot for the center with a smaller scale factor
quiver(X, Y, U_center, V_center, 1.7, 'g');

hold on;

% Create the quiver plot for the rest of the plot with a larger scale factor
quiver(X, Y, U_rest, V_rest, 2);

xlim([-10,10])
ylim([-10,10])