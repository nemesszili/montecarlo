clc;
close all;

tic();
L = 10;
p = 0.5;
SA = magnets(L, p);
x = 0.5:0.25:3.5;

y = [];

parfor i = x
  S = SA;
  [M, E, Cv, X] = ising(S, i);
  y = [y Cv];
end

plot(x, y, '-');
toc()