function dxdt = fun(~, x, q0, p1, s1, s2, p2, g, S1, S2)
    h1 = x(1); 
    h2 = x(2); 
    

    dh1dt = (q0 - p1 * s1 * sqrt(2 * g .* h1)) / S1;
    dh2dt = (p1 * s1 * sqrt(2 * g .* h1) - p2 * s2 * sqrt(2 * g .* h2)) / S2;

    dxdt = [dh1dt; dh2dt];
end