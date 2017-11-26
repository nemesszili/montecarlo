clc;
clear;
close all;

tic();
LL = [10 20 30];

for i = 1:length(LL)
  L = LL(i);
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
  
  legend_str{i} = strcat('L = ', num2str(L(i)));
  
end

figure(1);
title("Magnetization");
xlabel("Temperature");
ylabel("Magnetization");
legend(legend_str);
legend('boxon');
grid on;

figure(2);
title("Energy");
xlabel("Temperature");
ylabel("Energy");
legend(legend_str);
legend('boxon');
grid on;

figure(3);
title("Specific heat");
xlabel("Temperature");
ylabel("Specific heat");
legend(legend_str);
legend('boxon');
grid on;

figure(4);
title("Magnetic susceptibility");
xlabel("Temperature");
ylabel("Magnetic susceptibility");
legend(legend_str);
legend('boxon');
grid on;

toc()
