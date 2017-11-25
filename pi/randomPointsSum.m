clc;
clear;
hold on;
pkg load statistics;

N = 1000000;
X = unifrnd(0, 1, N, 1);
Y = unifrnd(0, 1, N, 1);

hist(X+Y, 20);
grid on;