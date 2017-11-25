clc;
clear;
close all;
rotate3d on;
%pkg load geometry;

N = 100000;
inside = 0;

%arc = [0 0 1 0 90];
%hold on;
%drawCircleArc(arc, 'LineWidth', 1, 'Color', 'r')
%hold on;

H = [];

tic();
for i = 1:N
  x = unifrnd(0, 1);
  y = unifrnd(0, 1);
  
  if ((x^2 + y^2) < 1)
    ++inside;
%    plot(x, y, 'color', 'b');
  else
%    plot(x, y, 'color', 'r');
  endif
  
  if (mod(i, 100) == 0)
    printf("%d\n", i);
    fflush(stdout);
  endif
  
  H = [x, y; H];
end
toc()
printf("Estimation of Pi: %f.4\n", 4*inside/N);

hist3(H);
grid on;
view(3);