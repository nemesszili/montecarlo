clc;
clear;
close all;

tic();
for L = 10:10:30
  S = ones(L);
  x = 0.5:0.05:3.5;

  Ms = [];
  Es = [];
  Cvs = [];
  Xs = [];

  % Initial stabilization before collecting samples
  S = stabilize(S, 0.5, 90000);

  disp("Stabilization done");

  for i = x
    % Wait for the system to reach stability
    S = stabilize(S, i, 10000);
    % Collect data
    [M, E, Cv, X] = ising(S, i);
    printf("T: %f --- M: %f, E: %f, Cv: %f, X: %f\n", i, M, E, Cv, X);
    fflush(stdout);
    
    Ms = [Ms M];
    Es = [Es E];
    Cvs = [Cvs Cv];
    Xs = [Xs X];
  end
  
  Ms = Ms / max(Ms);
  figure(1);
  plot(x, Ms, '-');
  hold on;
  
  Es = Es / max(Es);
  figure(2);
  plot(x, Es, '-');
  hold on;

  figure(3);
  plot(x, Cvs, '-');
  hold on;

  figure(4);
  plot(x, Xs, '-');
  hold on;
  
end

figure(1);
title("Magnetization");
xlabel("Temperature");
ylabel("Magnetization");
legend_str{1}='L = 10';
legend_str{2}='L = 20';
legend_str{3}='L = 30';
legend(legend_str);
legend('boxon');
grid on;

figure(2);
title("Energy");
xlabel("Temperature");
ylabel("Energy");
legend_str{1}='L = 10';
legend_str{2}='L = 20';
legend_str{3}='L = 30';
legend(legend_str);
legend('boxon');
grid on;

figure(3);
title("Specific heat");
xlabel("Temperature");
ylabel("Specific heat");
legend_str{1}='L = 10';
legend_str{2}='L = 20';
legend_str{3}='L = 30';
legend(legend_str);
legend('boxon');
grid on;

figure(4);
title("Magnetic susceptibility");
xlabel("Temperature");
ylabel("Magnetic susceptibility");
legend_str{1}='L = 10';
legend_str{2}='L = 20';
legend_str{3}='L = 30';
legend(legend_str);
legend('boxon');
grid on;

toc()