function xder = unlin(~, u, mu)
    u1 = u(1);
    u2 = u(2);
    
    u1dt = u2;
    u2dt = mu*(1 - u1.^2).*u2 - u1;
    
    xder=[u1dt; u2dt];
end 