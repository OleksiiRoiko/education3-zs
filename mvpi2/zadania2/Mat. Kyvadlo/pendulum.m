function dxdt = pendulum(~, x, l, g)
    theta = x(1);
    omega = x(2);
    
    dtheta_dt = omega;
    domega_dt = -(g/l)*sin(theta);
    
    dxdt = [dtheta_dt; domega_dt];
end
