function [M, E, Cv, X] = ising(S, T)  
  LL = numel(S);
  
  % Number of iterations
  N = 25000;
  
  % Boltzmann
  kB = 1.380648;
  
  % Energy and magnetization of each iteration
  E = [energy(S)];
  M = [magnetization(S)];
  
  for i = 1:N
    % Select random spin
    [x, y]  = ind2sub(size(S), randi(numel(S)));
    
    % Find its nearest neighbors
    above = mod(x - 1 - 1, size(S,1)) + 1;
    below = mod(x + 1 - 1, size(S,1)) + 1;
    left  = mod(y - 1 - 1, size(S,2)) + 1;
    right = mod(y + 1 - 1, size(S,2)) + 1;
    
    neighbors = [S(above,y);
       S(x,left);           S(x,right);
                 S(below,y)];
    
    % Calculate energy change if this spin is flipped
    dE = 2 * S(x, y) * sum(neighbors);
    
    % Boltzmann probability of flipping
    prob = exp(-dE/(kB*T));
    
    % Spin flip condition
    if dE <= 0 || rand() <= prob
        S(x, y) = -S(x, y);
        E = [E(1)+dE E];
        M = [magnetization(S) M];
    end
  end
  
  EE = mean(E .^ 2);
  MM = mean(M .^ 2);
  
  E  = mean(E);
  M  = mean(M);
  
  Cv = (EE - E^2)/(LL*kB*T*T);
  X  = (MM - M^2)/(LL*kB*T);
  
end