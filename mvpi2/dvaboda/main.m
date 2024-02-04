% pociatocne a koncove podmienky
x1poc = 0.4;
x2poc = 1;
x1konc = 1;
x2konc = 0.2;
p1poc = 0;
p2poc = 0;
eps = 0.001;
[t,x]=ode45('citlivostneRovOkrajUloha',[0
1],[x1poc,x2poc,p1poc,p2poc,0,0,0,0,1,0,0,1]);
while ( abs(x(end,1)-x1konc)>eps || abs(x(end,2)-x2konc)>eps ) 
 [t,x]=ode45('citlivostneRovOkrajUloha',[0
1],[x1poc,x2poc,p1poc,p2poc,0,0,0,0,1,0,0,1]);

 % prepocty delt kovektora p
 c = [ x(end,1)-x1konc;x(end,2)-x2konc ];
 e = [ -x(end,5:6);-x(end,7:8) ];
 dp = inv(e)*c;
 p1poc=x(1,3)+dp(1);
 p2poc=x(1,4)+dp(2);
end
plot(t,x(:,1),'r',t,x(:,2),'b')
grid on
title('Okrajova uloha - Van der Polov Oscilator')
legend('x1','x2') 