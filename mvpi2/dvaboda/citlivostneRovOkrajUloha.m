function xder = citlivostneRovOkrajUloha(~, x)
xder=[ x(2);
 -x(1)+x(4)+(1-(x(1)^2))*x(2);
 x(1)+x(4)*(1+2*x(1)*x(2));
 x(2)-x(3)-(1-x(1)^2)*x(4);
 x(7);
 x(8);
 (-1-2*x(1)*x(2))*x(5)+(1-x(1)^2)*x(7)+x(11);
 (-1-2*x(1)*x(2))*x(6)+(1-x(1)^2)*x(8)+x(12);
 (1+2*x(4)*x(2))*x(5)+2*x(1)*x(4)*x(7)+(1+2*x(1)*x(2))*x(11);
 (1+2*x(4)*x(2))*x(6)+2*x(1)*x(4)*x(8)+(1+2*x(1)*x(2))*x(12);
 2*x(1)*x(4)*x(5)+x(7)-x(9)+(x(1)^2-1)*x(11);
 2*x(1)*x(4)*x(6)+x(8)-x(10)+(x(1)^2-1)*x(12)
 ];
return