syms g p1 s1 p2 s2 R1 R2 h1 h2 S1 S2 q0

f = [(q0 - p1 * s1 * sqrt(2 * g .* h1)) / S1; 
    (p1 * s1 * sqrt(2 * g .* h1) - p2 * s2 * sqrt(2 * g .* h2)) / S2];

g_ = 9.81;
p1_ = 0.85;
s1_ = 0.083;
p2_ = 0.95;
s2_ = 0.083;
R1_ = 2;
R2_ = 2;
h1_ = 0.15;
a = p1_*s1_*sqrt(2*g_);
b = p2_*s2_*sqrt(2*g_);
h2_ = (a^2*h1_)/(b^2);
q0_ = b*sqrt(h2_);



S1_ = 2*pi*R1_*h1_ + 2*pi*R1_^2;
S2_ = 2*pi*R2_*h2_ + 2*pi*R2_^2;

A = jacobian(f, [h1, h2]);
simplify(A);
disp(A);
A = double(subs(A, [q0, g, h1, h2, p1, p2, s1, s2, R1, R2, S2, S1], ...
    [q0_, g_, h1_, h2_, p1_, p2_, s1_, s2_, R1_, R2_, S2_, S1_]));
disp(A);

B = jacobian(f, q0);
simplify(B);
disp(B);
B = double(subs(B, [q0, g, h1, h2, p1, p2, s1, s2, R1, R2, S2, S1], ... 
    [q0_, g_, h1_, h2_, p1_, p2_, s1_, s2_, R1_, R2_, S2_, S1_]));
disp(B);

C = [0 1];

D = 0;

sys = ss(A,B,C,D);

[num,den] = ss2tf (A , B , C , D );
w0 = den (2)/1.75;
K = (2.15* w0 ^2 - den (3))/ num (3);
I = w0 ^3/ num (3);


yData = sim("model2.slx");
y2Data = sim("model.slx");

figure(Name="Simulink model VS Simulink linerized model")
hold on;
plot(yData.system.Time, yData.system.Data, '--', 'LineWidth', 2);
plot(yData.lin.Time, yData.lin.Data, 'LineWidth', 2);
hold off;
xlabel('Time');
ylabel('Solution');
title("Simulink model VS Simulink linerized model");
legend("h2(t) nonlinear", "h2(t) linear");

figure(Name="Simulink model VS Simulink linerized model(PID)")
hold on;
plot(y2Data.system.Time, y2Data.system.Data, '--', 'LineWidth', 2);
plot(y2Data.lin.Time, y2Data.lin.Data, 'LineWidth', 2);
plot(y2Data.step.Time, y2Data.step.Data,'r--', 'LineWidth', 2);
line([y2Data.step.Time(1) y2Data.step.Time(end)],[h2_ h2_],'Color','r','LineWidth',1.4);
hold off;
xlabel('Time');
ylabel('Solution');
title("Simulink model VS Simulink linerized model(PID)");
legend("h2(t) nonlinear", "h2(t) linear");

