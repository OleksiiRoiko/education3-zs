syms g_ l_ b_ m_ x1 x2

g = 9.81;
l = 0.6;
b = 0.1;
m = 0.1;

tspan = [0 50];

f = [x2; -(g/l)*sin(x1)-(b/m)*x2];

J = jacobian(f, [x1, x2]);
disp(J);

J_at_equilibrium1 = double(subs(J, [x1,x2,g_,l_,b_,m_], [0,0,g,l,b,m]));

f_linear1 = @(t, Y) J_at_equilibrium1 * Y;

disp(eig(J_at_equilibrium1));


for i  = -5:1:5
    for j = -5:1:5
    x0 = [i j];
    [t_sol,x_sol] = ode45(f_linear1,tspan,x0);
    plot(x_sol(:,1), x_sol(:,2));
    hold on;
    end 
end
