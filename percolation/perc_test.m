clc;
clear;
close all;
pkg load image;

N = 10000;
L = [10 20 30];
p = 0:0.05:1;

tic();
for i = 1:length(L)
  % Run the simulation multiple times with the
  % same site occupation probability
  % and collect samples
  
  maxClAvgs = [];
  spProbs = [];
  
  for j = p
    maxClAvg = 0;
    spProb = 0;
    
    for k = 1:N
      [maxCl, sp] = percolation(L(i), j);
      
      maxClAvg += maxCl;
      spProb   += sp;
    end
    
    maxClAvgs = [maxClAvgs maxClAvg/N];
    spProbs   = [spProbs spProb/N];
    
    printf("p = %d, L = %d\n", j, L(i));
    printf("maxClAvg = %f, sp = %f\n", maxClAvg/N, spProb/N);
    fflush(stdout);
  end
  
  % Normalize
  maxClAvgs /= max(maxClAvgs);
  
  figure(1);
  plot(p, maxClAvgs, '-');
  hold on;
  
  figure(2);
  plot(p, spProbs, '-');
  hold on;
  
  legend_str{i} = strcat('L = ', num2str(L(i)));
end

figure(1);
title("Average of max cluster sizes");
xlabel("Site occupation probability (p)");
ylabel("Max cluster size average");
legend(legend_str);
legend('boxon');
grid on;

figure(2);
title("Spanning probability");
xlabel("Site occupation probability (p)");
ylabel("Spanning probability");
legend(legend_str);
legend('boxon');
grid on;

toc()