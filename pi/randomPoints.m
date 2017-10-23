clc;
clear;
hold on;
rotate3d on;
pkg load statistics;

N = 1000000;
X = unifrnd(0, 1, N, 2);

hist3(X);
grid on;
view(3);