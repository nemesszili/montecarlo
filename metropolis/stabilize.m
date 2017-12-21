function S = stabilize(S, T, N)
  % Boltzmann
  kB = 1.380648;
  
  for i = 1:N
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
    end
  end
end