function  xder = fun(~,x)
    xder = [x(2);-5.*x(2)-6.*x(1)];
end

