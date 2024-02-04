mu = 1; % Define the parameter for the Van der Pol oscillator

tspan = [0 10];

figure;

% определяем символы для переменных и параметра
syms x1 x2 real

% определяем систему уравнений
f = [x2;mu*(1 - x1.^2).*x2 - x1];

% вычисляем матрицу Якоби
J = jacobian(f, [x1; x2]);

% подставляем точку покоя {0;0} в матрицу Якоби
J_at_equilibrium = subs(J, [x1; x2], [0; 0]);

% преобразуем символьную матрицу в числовую
J_at_equilibrium = double(J_at_equilibrium);

% определяем линеаризованную систему дифференциальных уравнений
f_linear = @(t, Y) J_at_equilibrium * Y;

 % x0 = [1 1];
 % [t, x] = ode45(f_linear, tspan, x0);
 % plot(t, x,'r');

for i = -5:1:5
    for j = -5:1:5
        x0 = [i j];
        [t, x] = ode45(f_linear, tspan, x0);
        plot(x(:,1), x(:,2),'r');
        hold on;
    end
end

title('Phase Portrait of linear Van der Pol Oscillator');
xlabel('x');
ylabel('y');
[X, Y] = meshgrid(-10:10, -10:10);
U = J_at_equilibrium(1,1)*X + J_at_equilibrium(1,2)*Y;
V = J_at_equilibrium(2,1)*X + J_at_equilibrium(2,2)*Y;
quiver(X, Y, U, V,1.7,'g')
xlim([-10,10])
ylim([-10,10])