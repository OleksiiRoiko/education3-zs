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
q0_ = a*sqrt(h1_);

S1_ = 2*pi*R1_*h1_ + 2*pi*R1_^2;
S2_ = 2*pi*R2_*h2_ + 2*pi*R2_^2;


A = jacobian(f, [h1, h2]);
simplify(A);
A = double(subs(A, [q0, g, h1, h2, p1, p2, s1, s2, R1, R2, S2, S1], ...
    [q0_, g_, h1_, h2_, p1_, p2_, s1_, s2_, R1_, R2_, S2_, S1_]));

B = jacobian(f, q0);
simplify(B);
B = double(subs(B, [q0, g, h1, h2, p1, p2, s1, s2, R1, R2, S2, S1], ... 
    [q0_, g_, h1_, h2_, p1_, p2_, s1_, s2_, R1_, R2_, S2_, S1_]));

C = eye(2);
D = [0;0];

Q = eye(2);
R = 1;

K = lqr(A,B,Q,R);

disp(K);

N = 1/([0 1] *(-inv(A-B.*K'))* B);
disp(N);

y1Data = sim("modellqrN1.slx");

figure(Name="LQR + N unlinear model")
hold on;
plot(y1Data.riad.Time, y1Data.riad.Data, '-','Color','r', 'LineWidth', 1);
plot(y1Data.neriad.Time, y1Data.neriad.Data, '-','Color','g', 'LineWidth', 1);
plot(y1Data.step.Time, y1Data.step.Data, '-','Color','b', 'LineWidth', 1);
hold off;
xlabel('Time');
ylabel('Solution');
title("LQR + N linear model");
legend("h2(t) riad","h2(t) neriad","Trajectoria");

y2Data = sim("modellqr1.slx");

figure(Name="LQR nn do rovnovazneho stavu")
hold on;
plot(y2Data.unlinriad2.Time, y2Data.unlinriad2.Data, '-','Color','r', 'LineWidth', 1);
plot(y2Data.unlinneriad2.Time, y2Data.unlinneriad2.Data, '-','Color','b', 'LineWidth', 1);
hold off;
xlabel('Time');
ylabel('Solution');
title("LQR nn do rovnovazneho stavu");
legend("h2(t) unlinear riad", "h2(t) unlinear neriad");
