clc;
clear;
close all;
% pkg load statistics;

fprintf('Test run...\n');
% fflush(stdout);

[M, start_x, start_y, len] = gsaw(50000, 1, 1, true);
% dim = fractalDim(M, start_x, start_y);

% printf("Walk dimension: %f\nWalk length: %d\n", dim, len);
% fflush(stdout);

% Attraction levels
A = -1:0.25:1;

% Temperature levels
T = 1:50:300;

R = 200;
MC = 10000;

pause;

fprintf('Running extended simulation...\n');
% fflush(stdout);

for temp = T
  avgL = [];
  
  tic();
  for attr = A
    fprintf('Temp = %f, Attraction = %f... ', temp, attr);
%     fflush(stdout);
    
    L = 0;
    for i = 1:R
      [~, ~, ~, len] = gsaw(MC, attr, temp, false);  
      L = L + len;
    end
    
    avgL = [L/R avgL];
    
    fprintf('done\n');
%     fflush(stdout);
  end
  toc()
  
  figure;
  plot(A, avgL, '-');
  pause;
end