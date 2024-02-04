function dxdt = fun2(~, x, l, g, b, m)
    theta = x(1);
    omega = x(2);
    
    dtheta_dt = omega;
    domega_dt = -(g/l)*sin(theta) - b/m .* omega;
    
    dxdt = [dtheta_dt; domega_dt];
end
