syms K11 K12 K23 

K = [K11 K12; K12 K23];

A = [0 1; -6 -5];
B = [0;1];
C = eye(2);
D = [0;0];
Q1 = eye(2);
Q2 = [0.5 0; 0.5 0];
R1 = 1;
R2 = 0.1;

[K1,S,P] = lqr(A,B,Q1,R1);
[K2,S1,P1] = lqr(A,B,Q2,R2);
disp(K1);
disp(K2);

KK1 = -K*A - A'*K + K*B*inv(R1)*B'*K - Q1;
KK2 = -K*A - A'*K + K*B*inv(R2)*B'*K - Q2;
KK_vpa1 = vpa(KK1,5);
KK_vpa2 = vpa(KK2,5);

disp(KK_vpa1);
disp(KK_vpa2);

y1Data = sim("skuska.slx");


figure(Name="LQR model")
hold on;
% plot(y1Data.first.Time, y1Data.first.Data,'Color','r', 'LineWidth', 1);
% plot(y1Data.firstt.Time, y1Data.firstt.Data,'Color','g', 'LineWidth', 1);
plot(y1Data.second.Time, y1Data.second.Data,'Color','r', 'LineWidth', 1);
plot(y1Data.secondd.Time, y1Data.secondd.Data,'Color','b', 'LineWidth', 1);
hold off;
xlabel('Time');
ylabel('Solution');
title("LQR");
legend("2riad","2");



y1Data = sim("untitled1.slx");


figure(Name="LQR model")
hold on;
% plot(y1Data.first.Time, y1Data.first.Data,'Color','r', 'LineWidth', 1);
% plot(y1Data.firstt.Time, y1Data.firstt.Data,'Color','g', 'LineWidth', 1);
plot(y1Data.second.Time, y1Data.second.Data,'Color','r', 'LineWidth', 1);
plot(y1Data.second2.Time, y1Data.second2.Data,'Color','b', 'LineWidth', 1);
hold off;
xlabel('Time');
ylabel('Solution');
title("LQR dif R and Q");
legend("1riad","2riad");


figure(Name="U")
hold on;
% plot(y1Data.first.Time, y1Data.first.Data,'Color','r', 'LineWidth', 1);
% plot(y1Data.firstt.Time, y1Data.firstt.Data,'Color','g', 'LineWidth', 1);
plot(y1Data.u.Time, y1Data.u.Data,'Color','r', 'LineWidth', 1);
plot(y1Data.u2.Time, y1Data.u2.Data,'Color','b', 'LineWidth', 1);
hold off;
xlabel('Time');
ylabel('Solution');
title("U");
legend("1riad","2riad");