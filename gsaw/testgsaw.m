clc;
clear;
close all;
pkg load statistics;

printf("Test run...\n");
fflush(stdout);

[M, start_x, start_y, len] = gsaw(50000, 0, 1, false);
dim = fractalDim(M, start_x, start_y);

printf("Walk dimension: %f\nWalk length: %d\n", dim, len);
fflush(stdout);

% Attraction levels
A = -1:0.25:1;

% Temperature levels
T = 1:50:300;

R = 200;
MC = 10000;

printf("Running extended simulation...\n");
fflush(stdout);

for temp = T
  avgL = [];
  
  tic();
  for attr = A
    printf("Temp = %f, Attraction = %f... ", temp, attr);
    fflush(stdout);
    
    L = 0;
    for i = 1:R
      [~, ~, ~, len] = gsaw(MC, attr, temp, false);  
      L += len;
    end
    
    avgL = [L/R avgL];
    
    printf("done\n");
    fflush(stdout);
  end
  toc()
  
  figure;
  plot(A, avgL, '-');
  pause;
end