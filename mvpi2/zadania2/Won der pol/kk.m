% Определение переменных
syms lambda

Jacobian = [0 1;-1 1];

% Формула det(J-λI) = 0
det_equation = det(Jacobian - lambda*eye(size(Jacobian)));

% Вывод уравнения
disp('Determinant equation:');
disp(det_equation);

disp(roots([1,-1,1]))