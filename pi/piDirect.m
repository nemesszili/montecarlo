clc;
close;

N = 10000;
inside = 0;

arc = [0 0 1 0 90];
hold on;
drawCircleArc(arc, 'LineWidth', 1, 'Color', 'r')

hold on;

for i = 1:N
  x = unifrnd(0, 1);
  y = unifrnd(0, 1);
  
  if ((x^2 + y^2) < 1)
    ++inside;
    plot(x, y, 'color', 'b');
  else
    plot(x, y, 'color', 'r');
  endif
end

printf("Estimation of Pi: %f.4\n", 4*inside/N);